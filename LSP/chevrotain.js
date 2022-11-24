const path = require("path");
const fs = require("fs");
/* eslint-disable @typescript-eslint/naming-convention */
const chevrotain = require("chevrotain");

const createToken = chevrotain.createToken;
const Lexer = chevrotain.Lexer;
const CstParser = chevrotain.CstParser;

const ws = createToken({ name: "WhiteSpace", pattern: /\s+/, group: Lexer.SKIPPED });
const slc = createToken({ name: "SingleLineComment ", pattern: /\/\/[^\n\r]*/, group: Lexer.SKIPPED });
const mlc1 = createToken({ name: "MultiLineComment", pattern: /\/\*[\s\S]*?\*\//, group: Lexer.SKIPPED });
const mlc2 = createToken({ name: "MultiLineComment", pattern: /\(\*[\s\S]*?\*\)/, group: Lexer.SKIPPED });

const ns = createToken({ name: "NAMESPACE", pattern: /NAMESPACE/ });
const ens = createToken({ name: "END_NAMESPACE", pattern: /END_NAMESPACE/ });
const pg = createToken({ name: "PROGRAM", pattern: /PROGRAM/ });
const epg = createToken({ name: "END_PROGRAM", pattern: /END_PROGRAM/ });
const fb = createToken({ name: "FUNCTION_BLOCK", pattern: /FUNCTION_BLOCK/ });
const efb = createToken({ name: "END_FUNCTION_BLOCK", pattern: /END_FUNCTION_BLOCK/ });
const fun = createToken({ name: "FUNCTION", pattern: /FUNCTION/ });
const efun = createToken({ name: "END_FUNCTION", pattern: /END_FUNCTION/ });
const conf = createToken({ name: "CONFIGURATION", pattern: /CONFIGURATION/ });
const econf = createToken({ name: "END_CONFIGURATION", pattern: /END_CONFIGURATION/ });
const vg = createToken({ name: "VAR_GLOBAL", pattern: /VAR_GLOBAL/ });
const evg = createToken({ name: "END_VAR_GLOBAL", pattern: /END_VAR_GLOBAL/ });
const tp = createToken({ name: "TYPE", pattern: /TYPE/ });
const etp = createToken({ name: "END_TYPE", pattern: /END_TYPE/ });
const ovar = createToken({ name: "VAR", pattern: /VAR_?(INPUT|OUTPUT|IN_OUT|TEMP|EXTERNAL)?/ });
const evar = createToken({ name: "END_VAR", pattern: /END_VAR/ });
const varc = createToken({ name: "CONSTANT", pattern: /CONSTANT/ });
const varr = createToken({ name: "RETAIN", pattern: /RETAIN/ });
const varp = createToken({ name: "PERSISTANT", pattern: /PERSISTANT/ });
const at = createToken({ name: "AT", pattern: /AT/ });
const dd = createToken({ name: "DD", pattern: /:/ });
const cd = createToken({ name: "CD", pattern: /;/ });
const vtp = createToken({ name: "VAR TYPE", pattern: /(BOOL|U?(D|S)?INT)/ });
const variable = createToken({ name: "simbol", pattern: /[a-zA-Z]+[a-zA-Z0-9_]*/ });
const addr = createToken({ name: "ADDRESS", pattern: /\%(Q|I|M){1}(X|B|W|D|L){1}[0-9\.]+/ });
const comment = createToken({ name: "comment", pattern: /\(\*[\s\S]*\*\)/ });

dd.LABEL = ":";
cd.LABEL = ";";
ovar.LABEL = "VAR(INPUT|OUTPUT|IN_OUT|TEMP|EXTERNAL)";

const allTokens = [
    ws, slc, mlc1, mlc2, comment, addr, varr, varc, varp, ens, ns, epg, pg, efb, fb, efun, fun, conf, econf, vg, evg, evar, ovar, tp, etp, vtp, at, variable, dd, cd,
];

const stLexer = new Lexer(allTokens, {
    deferDefinitionErrorsHandling: true,
    recoveryEnabled: true,
    positionTracking: "onlyOffset",
});

class StParser extends CstParser {
    constructor() {
        super(allTokens);
        const $ = this;

        $.RULE("iecst", () => {
            $.MANY(() => {
                $.OR([
                    { ALT: () => $.SUBRULE($.namespace) },
                    { ALT: () => $.SUBRULE($.function) },
                    { ALT: () => $.SUBRULE($.program) },
                    { ALT: () => $.SUBRULE($.function_block) },
                    { ALT: () => $.SUBRULE($.var_global) },
                    { ALT: () => $.SUBRULE($.type_declaration) },
                    { ALT: () => $.SUBRULE($.configuration) }
                ]);
            });
        });

        $.RULE("namespace", () => {
            $.CONSUME(ns);
            $.CONSUME(variable, { LABEL: "Name" });
            $.MANY(() => {
                $.OR([
                    { ALT: () => $.SUBRULE($.function) },
                    { ALT: () => $.SUBRULE($.program) },
                    { ALT: () => $.SUBRULE($.function_block) },
                    { ALT: () => $.SUBRULE($.var_global) },
                    { ALT: () => $.SUBRULE($.type_declaration) },
                ]);
            });
            $.CONSUME(ens);
        });
        $.RULE("function", () => {
            $.CONSUME(fun);
            $.CONSUME(variable, { LABEL: 'function_name' });
            $.CONSUME(dd);
            $.SUBRULE($.var_type);
            $.SUBRULE($.var_block);
            // $.SUBRULE($.code);
            $.CONSUME(efun);
        });
        $.RULE("function_block", () => {
            $.CONSUME(fb);
            $.CONSUME(variable);
            $.SUBRULE($.var_block);
            $.CONSUME(efb);
        });
        $.RULE("var_global", () => {
            $.CONSUME(vg);
            $.OPTION(() => {
                $.SUBRULE($.var_keyword);
            });
            $.SUBRULE($.var_declaration);
            $.CONSUME(evg);
        });
        $.RULE("type_declaration", () => {
            $.CONSUME(tp);
            $.CONSUME(etp);
        });
        $.RULE("configuration", () => {
            $.CONSUME(conf);
            $.CONSUME(econf);
        });
        $.RULE("program", () => {
            $.CONSUME(pg);
            $.CONSUME(variable);
            $.SUBRULE($.var_block);
            $.CONSUME(epg);
        });


        $.RULE("var_block", () => {
            $.MANY(() => {
                $.CONSUME(ovar);
                $.OPTION(() => {
                    $.SUBRULE($.var_keyword);
                });
                $.SUBRULE($.var_declaration);
                $.CONSUME(evar);
            });
        });

        $.RULE("var_keyword", () => {
            $.MANY(() => {
                $.OR([
                    { ALT: () => $.CONSUME(varc) },
                    { ALT: () => $.CONSUME(varr) },
                    { ALT: () => $.CONSUME(varp) },
                ]);
            });
        });
        $.RULE("var_declaration", () => {
            $.MANY(() => {
                $.CONSUME(variable);
                $.OPTION(() => {
                    $.CONSUME(at);
                    $.CONSUME(addr);
                });
                $.CONSUME(dd);
                $.SUBRULE($.var_type);
                $.CONSUME(cd);
            });
        });
        $.RULE("var_type", () => {

            $.OR([
                { ALT: () => $.CONSUME(vtp) },
                { ALT: () => $.CONSUME(variable) }
            ]);
        });
        this.performSelfAnalysis();
    }
};


let inputText = `
FUNCTION myname : BOOL
    VAR
        xStart: BOOL; (* Comment *)
        xStop: BOOL; (* Comment *)
    END_VAR
    VAR_INPUT
        iNum AT %QX0.0.0: INT; (* Comment *)

    END_VAR

END_FUNCTION`;
let lexingResult = stLexer.tokenize(inputText);
//console.log(lexingResult?.tokens);

const parser = new StParser();
parser.input = lexingResult.tokens;
parser.iecst();

if (parser.errors.length > 0) {
    console.log(parser.errors[0]);
} else {
    console.log(parser);
}


const serializedGrammar = parser.getSerializedGastProductions();
const htmlText = chevrotain.createSyntaxDiagramsCode(serializedGrammar);
const outPath = path.resolve(__dirname, "./")
fs.writeFileSync(outPath + "/generated_diagrams.html", htmlText);

/*
return {
    lexer: stLexer,
    parser: StParser,
    defaultRule: "iecst"
};
*/
