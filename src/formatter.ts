'use strict';
import * as vscode from 'vscode';

export class STFormatterProvider implements vscode.DocumentFormattingEditProvider {
    private functions: Array<string> = [];
    private keywords: Array<string> = [];
    private types: Array<string> = [];
    private ends: Array<string> = [];
    private skipString: Array<string> = [];

    provideDocumentFormattingEdits(document: vscode.TextDocument) {
        if (vscode.window.visibleTextEditors.every((e) => e.document.fileName !== document.fileName)) {
            return [];
        }

        let out = [];
        this.functions = [
            'abs', 'sin', 'mod', 'abs', 'acos', 'asin', 'atan', 'cos', 'exp',
            'expt', 'ln', 'log', 'sin', 'sqrt', 'tan', 'sel', 'mux', 'shl',
            'shr', 'rol', 'ror', 'add', 'div', 'mul', 'sub', 'limit', 'max',
            'min', 'adr', 'adrinst', 'size', 'sizeof', 'bit_adr', 'bit_trunc',
            'rs', 'sr', 'ton', 'tp', 'tof', 'trunc', 'ctd', 'ctu', 'ctud', 'r_trig',
            'f_trig', 'move', 'concat', 'delete', 'find', 'insert', 'left', 'len',
            'replace', 'right', 'rtc', 'mid', 'sema', 'round', 'floor', 'ceil',
            'unpack', 'ref', '__new', '__delete',

            // GXW2 inscructions
            'addp', 'dadd', 'daddp', 'subp', 'dsub', 'dsubp', 'mulp', 'dmul', 'dmulp', 'divp',
            'ddiv', 'ddivp', 'inc', 'incp', 'dinc', 'dincp', 'dec', 'decp', 'ddec', 'ddecp',
            'wand', 'wandp', 'dand', 'dandp', 'wor', 'worp', 'dor', 'dorp', 'wxor', 'wxorp',
            'dxor', 'dxorp', 'neg', 'negp', 'dneg', 'dnegp', 'decmp', 'decmpp', 'dezcp',
            'dezcpp', 'demov', 'demovp', 'destr', 'destrp', 'deval', 'devalp', 'debcd', 'debcdp',
            'debin', 'debinp', 'deadd', 'deaddp', 'desub', 'desubp', 'demul', 'demulp', 'dediv',
            'dedivp', 'dexp', 'dexpp', 'dloge', 'dlogep', 'dlog10', 'dlog10p', 'desqr', 'desqrp',
            'deneg', 'denegp', 'int', 'intp', 'dint', 'dintp', 'dsin', 'dsinp', 'dcos', 'dcosp',
            'dtan', 'dtanp', 'dasin', 'dasinp', 'dacos', 'dacosp', 'datan', 'datanp', 'drad',
            'dradp', 'ddeg', 'ddegp', 'limitation', 'limit', 'limitp', 'dlimit', 'dlimitp', 'band',
            'bandp', 'dband', 'dbandp', 'zone', 'zonep', 'dzone', 'dzonep', 'scl', 'sclp', 'dscl',
            'dsclp', 'dabin', 'dabinp', 'ddabin', 'ddabinp', 'binda', 'bin', 'bindap', 'dbinda',
            'dbindap', 'scl2', 'scl2p', 'dscl2', 'dscl2p', 'dszr', 'dvit', 'ddvit', 'dtbl', 'dabs',
            'zrn', 'dzrn', 'plsv', 'dplsv', 'drvi', 'ddrvi', 'drva', 'ddrva', 'wsum', 'wsump',
            'dwsum', 'dwsump', 'wtob', 'wtobp', 'btow', 'btowp', 'uni', 'unip', 'dis', 'disp',
            'swap', 'swapp', 'dswap', 'dswapp', 'sort2', 'dsort2', 'ror', 'rorp', 'dror', 'drorp',
            'rol', 'rolp', 'drol', 'drolp', 'rcr', 'rcrp', 'drcr', 'drcrp', 'rcl', 'rclp', 'drcl',
            'drclp', 'sftr', 'sftrp', 'sftl', 'sftlp', 'wsfr', 'wsfrp', 'wsfl', 'wsflp', 'sfwr',
            'sfwrp', 'sfrd', 'sfrdp', 'refp', 'reff', 'reffp', 'mtr', 'dhscs', 'dhscs_i', 'dhscr',
            'dhsz', 'spd', 'dspd', 'plsy', 'dplsy', 'pwm', 'plsr', 'dplsr', 'ist', 'ser', 'serp',
            'dser', 'dserp', 'absd', 'dabsd', 'incd', 'ttmr', 'stmr', 'alt', 'altp', 'ramp',
            'rotc', 'sort', 'cmp', 'cmpp', 'dcmp', 'dcmpp', 'zcp', 'zcpp', 'dzcp', 'dzcpp',
            'mov', 'movp', 'dmov', 'dmovp', 'smov', 'smovp', 'cml', 'cmlp', 'dcml', 'dcmlp',
            'bmov', 'bmovp', 'fmov', 'fmovp', 'dfmov', 'dfmovp', 'xch', 'xchp', 'dxch', 'dxchp',
            'bcd', 'bcdp', 'dbcd', 'dbcdp', 'bin', 'binp', 'dbin', 'dbinp',

            '[A-Za-z_]*(_TO_)[A-Za-z_]*', '(?:TO_|FROM_|TRUNC_)[A-Za-z_]*'
        ];

        this.keywords = [
            'true', 'false', 'exit', 'continue', 'return', 'constant', 'retain',
            'public', 'private', 'protected', 'abstract', 'persistent', 'internal',
            'final', 'of', 'else', 'elsif', 'then', '__try', '__catch', '__finally',
            '__endtry', 'do', 'to', 'by', 'task', 'with', 'using', 'uses', 'from',
            'until', 'or', 'or_else', 'and', 'and_then', 'not', 'xor', 'nor', 'ge',
            'le', 'eq', 'ne', 'gt', 'lt', 'extends', 'implements', 'this', 'super',
            '(?:T|DT|TOD|D)#(?=[0-9])',
            // '(?:T|DT|TOD|D)#[0-9\\:\\-\\_yYmMdDhHsS]+',
            'var_(?:input|output|in_out|temp|global|access|external)'
        ];

        this.types = [
            'AT', 'BOOL', 'BYTE', '(?:D|L)?WORD', 'U?(?:S|D|L)?INT', 'L?REAL',
            'TIME(?:_OF_DAY)?', 'TOD', 'DT', 'DATE(?:_AND_TIME)?', 'W?STRING',
            'ARRAY', 'ANY', 'ANY_(?:NUM|INT|REAL)'];

        this.ends = [
            'var', 'program', 'if', 'case', 'while', 'for', 'repeat', 'function',
            'function_block', 'struct', 'configuration', 'tcp', 'resource',
            'channel', 'library', 'folder', 'binaries', 'includes', 'sources',
            'action', 'step', 'initial_step', 'transition', 'type', 'namespace',
            'implementation', 'interface', 'property', 'get', 'set', 'method', 'union', 'class'
        ];

        // Do not format this strings
        this.skipString = [
            `["']{1}[^\"\'\\\\]*(?:\\\\[\\s\\S][^"'\\\\]*)*["']{1}`, // All strings in quotes
            '\\(\\*[\\s\\S]*?\\*\\)', // All comments in braces
            '\\/\\*[\\s\\S]*?\\*\\/', // All comments in slashes
            '\\/\\/[^\\n]*\\n' // All single line comments
        ];

        let text = document.getText();

        text = this.spaces(text);
        text = this.capitalize(text);

        out.push(
            new vscode.TextEdit(new vscode.Range(
                new vscode.Position(0, 0),
                document.lineAt(document.lineCount - 1).range.end), text
            )
        );

        return out;
    }

    spaces(text: string): string {
        // Delete all double spaces
        while(text.match(/(?<!^| )  /gm)!== null) {
            text = text.replace(/(?<!^| )  /gm, " ");
        }

        // Delete space between func name and (
        // ABS ( to ABS(
        let regEx = new RegExp(`\\b(?:${this.functions.join('|')})\\b\\s+\\(`, "ig");
        text = text.replace(regEx, (match) => {
            return match.replace(/\s+/, '');
        });

        // Add space after keywords
        // IF( to IF (
        regEx = new RegExp(`\\b(IF|WHILE|CASE)\\(`, "ig");
        text = text.replace(regEx, (match, key) => {
            return key !== undefined ? key + ' (' : match;
        });

        // Add before after keywords
        // )THEN to ) THEN
        regEx = new RegExp(`\\)(THEN|DO|OF)\\b`, "ig");
        text = text.replace(regEx, (match, key) => {
            return key !== undefined ? ') ' + key : match;
        });

        let addSpace = {
            csb: ['\\*\\)', '\\*\\/', '(?<=.)\\/\\/', '(?<=.)\\(\\*', '(?<=.)\\/\\*'],
            csa: ['\\(\\*', '\\/\\*', '\\/\\/'],
            ss:  [':=', '<>', '>=', '<=', '=>', '\\+', '\\-', '\\/'],
            sb:  ['(?<!<|>|:)=', ':', '(?<!\\*)\\*(?!\\*)', '<', '(?<!=|<)>'],
            sa:  ['=(?!>| )', ':(?!=)', '\\*(?!\\*|;)', ',', '<(?!=|>)', '>(?!=)']
        };

        regEx = new RegExp(`(?<! |\\t)(${addSpace.csb.join('|')})`, "ig");
        text = text.replace(regEx, (match, sign) => " " + sign);
        regEx = new RegExp(`(${addSpace.csa.join('|')})(?! |\\t)`, "ig");
        text = text.replace(regEx, (match, sign) => sign + " ");

        regEx = new RegExp(`${this.skipString.join('|')}|(?<! |\\t)(${addSpace.ss.join('|')}|${addSpace.sb.join('|')})`, "ig");
        text = text.replace(regEx, (match, sign) => sign !== undefined ? " " + sign : match);
        regEx = new RegExp(`${this.skipString.join('|')}|(${addSpace.ss.join('|')}|${addSpace.sa.join('|')})(?! |\\t)`, "ig");
        text = text.replace(regEx, (match, sign) => sign !== undefined ? sign + " " : match);

        // Delete all spaces at the end of the lines
        text = text.split("\n").map(el => el.trimEnd()).join("\n");

        // regEx = new RegExp(`[\s]+:(?!=)`, "ig");
        text = text.replace(/[\s]+:(?!=)/g, ":");
        // regEx = new RegExp(`;[\s]+\n$`, "ig");
        text = text.replace(/;[\s]+\n$/g, ";\n");



        return text;
    }

    capitalize(text: string): string {
        let regEx = new RegExp(`(?<!\\\\(?:\\\\{2})*)${this.skipString.join('|')}|\\b(${this.types.join('|')}|${this.keywords.join('|')}|(?:END_)?(?:${this.ends.join('|')})|${this.functions.join('\\(|')}\\()\\b`, "ig");
        text = text.replace(regEx, (match, group) => {
            return group !== undefined ? match.toUpperCase() : match;
        });

        text = text.replace(/(?<=T|DT|TOD|D)#[0-9\\:\\-\\_yYmMdDhHsS]+/ig, (match, group) => {
            return group !== undefined ? match.toLowerCase() : match;
        });

        return text;
    }
}
