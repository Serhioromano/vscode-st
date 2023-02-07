// Generated from /home/sergey/www/VSCODE/vscode-st/ST.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class STParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, T__36=37, T__37=38, 
		T__38=39, T__39=40, T__40=41, LA=42, ID=43, DT=44, ANY_INT=45, ANY_BIT=46, 
		ANY_STRING=47, ANY_REAL=48, ANY_TIME=49, VAROPEN=50, ARRAY=51, NUMERIC=52, 
		VARKEY=53, LOOP=54, WHITESPACE=55, NEWLINE=56, OPERATOR=57, INTEGER=58, 
		STRING_S=59, STRING_D=60, STRING=61, FLOAT=62, SingleLineComment=63, MultiLineComment=64;
	public static final int
		RULE_compilePOU = 0, RULE_namespaceDeclaration = 1, RULE_programDeclaration = 2, 
		RULE_typeDeclaration = 3, RULE_functionBlockDeclaration = 4, RULE_functionDeclaration = 5, 
		RULE_globalVar = 6, RULE_typeUnit = 7, RULE_typeKindEnum = 8, RULE_enumNameUnit = 9, 
		RULE_enumVal = 10, RULE_typeKindAlias = 11, RULE_typeKindStruct = 12, 
		RULE_varDeclarationList = 13, RULE_varDeclarationSet = 14, RULE_varDeclaration = 15, 
		RULE_statementList = 16, RULE_statement = 17, RULE_statementAssign = 18, 
		RULE_varNameAssign = 19, RULE_statementIf = 20, RULE_statementWhile = 21, 
		RULE_statementRepeat = 22, RULE_statementFor = 23, RULE_statementCase = 24, 
		RULE_caseItemList = 25, RULE_caseItem = 26, RULE_statementListBreak = 27, 
		RULE_expression = 28, RULE_functionParams = 29, RULE_functionParam = 30, 
		RULE_programName = 31, RULE_typeName = 32, RULE_functionName = 33, RULE_functionBlockName = 34, 
		RULE_nsName = 35, RULE_enumName = 36, RULE_varName = 37, RULE_enumValue = 38, 
		RULE_dataType = 39, RULE_dataTypeValue = 40;
	private static String[] makeRuleNames() {
		return new String[] {
			"compilePOU", "namespaceDeclaration", "programDeclaration", "typeDeclaration", 
			"functionBlockDeclaration", "functionDeclaration", "globalVar", "typeUnit", 
			"typeKindEnum", "enumNameUnit", "enumVal", "typeKindAlias", "typeKindStruct", 
			"varDeclarationList", "varDeclarationSet", "varDeclaration", "statementList", 
			"statement", "statementAssign", "varNameAssign", "statementIf", "statementWhile", 
			"statementRepeat", "statementFor", "statementCase", "caseItemList", "caseItem", 
			"statementListBreak", "expression", "functionParams", "functionParam", 
			"programName", "typeName", "functionName", "functionBlockName", "nsName", 
			"enumName", "varName", "enumValue", "dataType", "dataTypeValue"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'NAMESPACE'", "'END_NAMESPACE'", "'PROGRAM'", "'END_PROGRAM'", 
			"'TYPE'", "':'", "'END_TYPE'", "'FUNCTION_BLOCK'", "'END_FUNCTION_BLOCK'", 
			"'FUNCTION'", "'END_FUNCTION'", "'VAR_GLOBAL'", "'END_VAR'", "'('", "','", 
			"')'", "':='", "';'", "'STRUCT'", "'END_STRUCT'", "'AT'", "'.'", "'IF'", 
			"'THEN'", "'END_IF'", "'ELSEIF'", "'ELSE'", "'WHILE'", "'DO'", "'END_WHILE'", 
			"'REPEAT'", "'UNTIL'", "'END_REPEAT'", "'FOR'", "'TO'", "'BY'", "'END_FOR'", 
			"'CASE'", "'OF'", "'END_CASE'", "'=>'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, "LA", "ID", "DT", "ANY_INT", "ANY_BIT", 
			"ANY_STRING", "ANY_REAL", "ANY_TIME", "VAROPEN", "ARRAY", "NUMERIC", 
			"VARKEY", "LOOP", "WHITESPACE", "NEWLINE", "OPERATOR", "INTEGER", "STRING_S", 
			"STRING_D", "STRING", "FLOAT", "SingleLineComment", "MultiLineComment"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "ST.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public STParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class CompilePOUContext extends ParserRuleContext {
		public NamespaceDeclarationContext namespaceDeclaration() {
			return getRuleContext(NamespaceDeclarationContext.class,0);
		}
		public ProgramDeclarationContext programDeclaration() {
			return getRuleContext(ProgramDeclarationContext.class,0);
		}
		public FunctionDeclarationContext functionDeclaration() {
			return getRuleContext(FunctionDeclarationContext.class,0);
		}
		public FunctionBlockDeclarationContext functionBlockDeclaration() {
			return getRuleContext(FunctionBlockDeclarationContext.class,0);
		}
		public GlobalVarContext globalVar() {
			return getRuleContext(GlobalVarContext.class,0);
		}
		public TypeDeclarationContext typeDeclaration() {
			return getRuleContext(TypeDeclarationContext.class,0);
		}
		public CompilePOUContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_compilePOU; }
	}

	public final CompilePOUContext compilePOU() throws RecognitionException {
		CompilePOUContext _localctx = new CompilePOUContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_compilePOU);
		try {
			setState(88);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
				enterOuterAlt(_localctx, 1);
				{
				setState(82);
				namespaceDeclaration();
				}
				break;
			case T__2:
				enterOuterAlt(_localctx, 2);
				{
				setState(83);
				programDeclaration();
				}
				break;
			case T__9:
				enterOuterAlt(_localctx, 3);
				{
				setState(84);
				functionDeclaration();
				}
				break;
			case T__7:
				enterOuterAlt(_localctx, 4);
				{
				setState(85);
				functionBlockDeclaration();
				}
				break;
			case T__11:
				enterOuterAlt(_localctx, 5);
				{
				setState(86);
				globalVar();
				}
				break;
			case T__4:
				enterOuterAlt(_localctx, 6);
				{
				setState(87);
				typeDeclaration();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NamespaceDeclarationContext extends ParserRuleContext {
		public NsNameContext nsName() {
			return getRuleContext(NsNameContext.class,0);
		}
		public List<CompilePOUContext> compilePOU() {
			return getRuleContexts(CompilePOUContext.class);
		}
		public CompilePOUContext compilePOU(int i) {
			return getRuleContext(CompilePOUContext.class,i);
		}
		public NamespaceDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_namespaceDeclaration; }
	}

	public final NamespaceDeclarationContext namespaceDeclaration() throws RecognitionException {
		NamespaceDeclarationContext _localctx = new NamespaceDeclarationContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_namespaceDeclaration);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(90);
			match(T__0);
			setState(91);
			nsName();
			setState(95);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__2) | (1L << T__4) | (1L << T__7) | (1L << T__9) | (1L << T__11))) != 0)) {
				{
				{
				setState(92);
				compilePOU();
				}
				}
				setState(97);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(98);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ProgramDeclarationContext extends ParserRuleContext {
		public ProgramNameContext programName() {
			return getRuleContext(ProgramNameContext.class,0);
		}
		public VarDeclarationListContext varDeclarationList() {
			return getRuleContext(VarDeclarationListContext.class,0);
		}
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public ProgramDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_programDeclaration; }
	}

	public final ProgramDeclarationContext programDeclaration() throws RecognitionException {
		ProgramDeclarationContext _localctx = new ProgramDeclarationContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_programDeclaration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(100);
			match(T__2);
			setState(101);
			programName();
			setState(102);
			varDeclarationList();
			setState(103);
			statementList();
			setState(104);
			match(T__3);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeDeclarationContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public TypeUnitContext typeUnit() {
			return getRuleContext(TypeUnitContext.class,0);
		}
		public TypeDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeDeclaration; }
	}

	public final TypeDeclarationContext typeDeclaration() throws RecognitionException {
		TypeDeclarationContext _localctx = new TypeDeclarationContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_typeDeclaration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(106);
			match(T__4);
			setState(107);
			typeName();
			setState(108);
			match(T__5);
			setState(109);
			typeUnit();
			setState(110);
			match(T__6);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionBlockDeclarationContext extends ParserRuleContext {
		public FunctionBlockNameContext functionBlockName() {
			return getRuleContext(FunctionBlockNameContext.class,0);
		}
		public VarDeclarationListContext varDeclarationList() {
			return getRuleContext(VarDeclarationListContext.class,0);
		}
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public FunctionBlockDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionBlockDeclaration; }
	}

	public final FunctionBlockDeclarationContext functionBlockDeclaration() throws RecognitionException {
		FunctionBlockDeclarationContext _localctx = new FunctionBlockDeclarationContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_functionBlockDeclaration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(112);
			match(T__7);
			setState(113);
			functionBlockName();
			setState(114);
			varDeclarationList();
			setState(115);
			statementList();
			setState(116);
			match(T__8);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionDeclarationContext extends ParserRuleContext {
		public FunctionNameContext functionName() {
			return getRuleContext(FunctionNameContext.class,0);
		}
		public DataTypeContext dataType() {
			return getRuleContext(DataTypeContext.class,0);
		}
		public VarDeclarationListContext varDeclarationList() {
			return getRuleContext(VarDeclarationListContext.class,0);
		}
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public FunctionDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionDeclaration; }
	}

	public final FunctionDeclarationContext functionDeclaration() throws RecognitionException {
		FunctionDeclarationContext _localctx = new FunctionDeclarationContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_functionDeclaration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(118);
			match(T__9);
			setState(119);
			functionName();
			setState(120);
			match(T__5);
			setState(121);
			dataType();
			setState(122);
			varDeclarationList();
			setState(123);
			statementList();
			setState(124);
			match(T__10);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class GlobalVarContext extends ParserRuleContext {
		public List<TerminalNode> VARKEY() { return getTokens(STParser.VARKEY); }
		public TerminalNode VARKEY(int i) {
			return getToken(STParser.VARKEY, i);
		}
		public List<VarDeclarationContext> varDeclaration() {
			return getRuleContexts(VarDeclarationContext.class);
		}
		public VarDeclarationContext varDeclaration(int i) {
			return getRuleContext(VarDeclarationContext.class,i);
		}
		public GlobalVarContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_globalVar; }
	}

	public final GlobalVarContext globalVar() throws RecognitionException {
		GlobalVarContext _localctx = new GlobalVarContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_globalVar);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(126);
			match(T__11);
			setState(130);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==VARKEY) {
				{
				{
				setState(127);
				match(VARKEY);
				}
				}
				setState(132);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(136);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==ID) {
				{
				{
				setState(133);
				varDeclaration();
				}
				}
				setState(138);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(139);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeUnitContext extends ParserRuleContext {
		public TypeKindAliasContext typeKindAlias() {
			return getRuleContext(TypeKindAliasContext.class,0);
		}
		public TypeKindEnumContext typeKindEnum() {
			return getRuleContext(TypeKindEnumContext.class,0);
		}
		public TypeKindStructContext typeKindStruct() {
			return getRuleContext(TypeKindStructContext.class,0);
		}
		public TypeUnitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeUnit; }
	}

	public final TypeUnitContext typeUnit() throws RecognitionException {
		TypeUnitContext _localctx = new TypeUnitContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_typeUnit);
		try {
			setState(144);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case ID:
			case DT:
				enterOuterAlt(_localctx, 1);
				{
				setState(141);
				typeKindAlias();
				}
				break;
			case T__13:
				enterOuterAlt(_localctx, 2);
				{
				setState(142);
				typeKindEnum();
				}
				break;
			case T__18:
				enterOuterAlt(_localctx, 3);
				{
				setState(143);
				typeKindStruct();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeKindEnumContext extends ParserRuleContext {
		public List<EnumNameUnitContext> enumNameUnit() {
			return getRuleContexts(EnumNameUnitContext.class);
		}
		public EnumNameUnitContext enumNameUnit(int i) {
			return getRuleContext(EnumNameUnitContext.class,i);
		}
		public EnumValueContext enumValue() {
			return getRuleContext(EnumValueContext.class,0);
		}
		public TypeKindEnumContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeKindEnum; }
	}

	public final TypeKindEnumContext typeKindEnum() throws RecognitionException {
		TypeKindEnumContext _localctx = new TypeKindEnumContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_typeKindEnum);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(146);
			match(T__13);
			setState(147);
			enumNameUnit();
			setState(152);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__14) {
				{
				{
				setState(148);
				match(T__14);
				setState(149);
				enumNameUnit();
				}
				}
				setState(154);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(155);
			match(T__15);
			setState(158);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16) {
				{
				setState(156);
				match(T__16);
				setState(157);
				enumValue();
				}
			}

			setState(160);
			match(T__17);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumNameUnitContext extends ParserRuleContext {
		public EnumNameContext enumName() {
			return getRuleContext(EnumNameContext.class,0);
		}
		public EnumValContext enumVal() {
			return getRuleContext(EnumValContext.class,0);
		}
		public EnumNameUnitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumNameUnit; }
	}

	public final EnumNameUnitContext enumNameUnit() throws RecognitionException {
		EnumNameUnitContext _localctx = new EnumNameUnitContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_enumNameUnit);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(162);
			enumName();
			setState(165);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16) {
				{
				setState(163);
				match(T__16);
				setState(164);
				enumVal();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumValContext extends ParserRuleContext {
		public TerminalNode INTEGER() { return getToken(STParser.INTEGER, 0); }
		public EnumNameContext enumName() {
			return getRuleContext(EnumNameContext.class,0);
		}
		public EnumValContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumVal; }
	}

	public final EnumValContext enumVal() throws RecognitionException {
		EnumValContext _localctx = new EnumValContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_enumVal);
		try {
			setState(169);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case INTEGER:
				enterOuterAlt(_localctx, 1);
				{
				setState(167);
				match(INTEGER);
				}
				break;
			case ID:
				enterOuterAlt(_localctx, 2);
				{
				setState(168);
				enumName();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeKindAliasContext extends ParserRuleContext {
		public DataTypeContext dataType() {
			return getRuleContext(DataTypeContext.class,0);
		}
		public DataTypeValueContext dataTypeValue() {
			return getRuleContext(DataTypeValueContext.class,0);
		}
		public TypeKindAliasContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeKindAlias; }
	}

	public final TypeKindAliasContext typeKindAlias() throws RecognitionException {
		TypeKindAliasContext _localctx = new TypeKindAliasContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_typeKindAlias);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(171);
			dataType();
			setState(174);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16) {
				{
				setState(172);
				match(T__16);
				setState(173);
				dataTypeValue();
				}
			}

			setState(176);
			match(T__17);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeKindStructContext extends ParserRuleContext {
		public List<VarDeclarationContext> varDeclaration() {
			return getRuleContexts(VarDeclarationContext.class);
		}
		public VarDeclarationContext varDeclaration(int i) {
			return getRuleContext(VarDeclarationContext.class,i);
		}
		public TypeKindStructContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeKindStruct; }
	}

	public final TypeKindStructContext typeKindStruct() throws RecognitionException {
		TypeKindStructContext _localctx = new TypeKindStructContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_typeKindStruct);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(178);
			match(T__18);
			setState(182);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==ID) {
				{
				{
				setState(179);
				varDeclaration();
				}
				}
				setState(184);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(185);
			match(T__19);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarDeclarationListContext extends ParserRuleContext {
		public List<VarDeclarationSetContext> varDeclarationSet() {
			return getRuleContexts(VarDeclarationSetContext.class);
		}
		public VarDeclarationSetContext varDeclarationSet(int i) {
			return getRuleContext(VarDeclarationSetContext.class,i);
		}
		public VarDeclarationListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varDeclarationList; }
	}

	public final VarDeclarationListContext varDeclarationList() throws RecognitionException {
		VarDeclarationListContext _localctx = new VarDeclarationListContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_varDeclarationList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(190);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==VAROPEN) {
				{
				{
				setState(187);
				varDeclarationSet();
				}
				}
				setState(192);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarDeclarationSetContext extends ParserRuleContext {
		public TerminalNode VAROPEN() { return getToken(STParser.VAROPEN, 0); }
		public List<TerminalNode> VARKEY() { return getTokens(STParser.VARKEY); }
		public TerminalNode VARKEY(int i) {
			return getToken(STParser.VARKEY, i);
		}
		public List<VarDeclarationContext> varDeclaration() {
			return getRuleContexts(VarDeclarationContext.class);
		}
		public VarDeclarationContext varDeclaration(int i) {
			return getRuleContext(VarDeclarationContext.class,i);
		}
		public VarDeclarationSetContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varDeclarationSet; }
	}

	public final VarDeclarationSetContext varDeclarationSet() throws RecognitionException {
		VarDeclarationSetContext _localctx = new VarDeclarationSetContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_varDeclarationSet);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(193);
			match(VAROPEN);
			setState(197);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==VARKEY) {
				{
				{
				setState(194);
				match(VARKEY);
				}
				}
				setState(199);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(203);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==ID) {
				{
				{
				setState(200);
				varDeclaration();
				}
				}
				setState(205);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(206);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarDeclarationContext extends ParserRuleContext {
		public List<VarNameContext> varName() {
			return getRuleContexts(VarNameContext.class);
		}
		public VarNameContext varName(int i) {
			return getRuleContext(VarNameContext.class,i);
		}
		public DataTypeContext dataType() {
			return getRuleContext(DataTypeContext.class,0);
		}
		public DataTypeValueContext dataTypeValue() {
			return getRuleContext(DataTypeValueContext.class,0);
		}
		public TerminalNode LA() { return getToken(STParser.LA, 0); }
		public VarDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varDeclaration; }
	}

	public final VarDeclarationContext varDeclaration() throws RecognitionException {
		VarDeclarationContext _localctx = new VarDeclarationContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_varDeclaration);
		int _la;
		try {
			setState(235);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,17,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(208);
				varName();
				setState(213);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__14) {
					{
					{
					setState(209);
					match(T__14);
					setState(210);
					varName();
					}
					}
					setState(215);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(216);
				match(T__5);
				setState(217);
				dataType();
				setState(220);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__16) {
					{
					setState(218);
					match(T__16);
					setState(219);
					dataTypeValue();
					}
				}

				setState(222);
				match(T__17);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(224);
				varName();
				setState(225);
				match(T__20);
				setState(226);
				match(LA);
				setState(227);
				match(T__5);
				setState(228);
				dataType();
				setState(231);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__16) {
					{
					setState(229);
					match(T__16);
					setState(230);
					dataTypeValue();
					}
				}

				setState(233);
				match(T__17);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementListContext extends ParserRuleContext {
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public StatementListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementList; }
	}

	public final StatementListContext statementList() throws RecognitionException {
		StatementListContext _localctx = new StatementListContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_statementList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(240);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__22) | (1L << T__27) | (1L << T__30) | (1L << T__33) | (1L << T__37) | (1L << ID))) != 0)) {
				{
				{
				setState(237);
				statement();
				}
				}
				setState(242);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementContext extends ParserRuleContext {
		public StatementAssignContext statementAssign() {
			return getRuleContext(StatementAssignContext.class,0);
		}
		public StatementIfContext statementIf() {
			return getRuleContext(StatementIfContext.class,0);
		}
		public StatementWhileContext statementWhile() {
			return getRuleContext(StatementWhileContext.class,0);
		}
		public StatementForContext statementFor() {
			return getRuleContext(StatementForContext.class,0);
		}
		public StatementRepeatContext statementRepeat() {
			return getRuleContext(StatementRepeatContext.class,0);
		}
		public StatementCaseContext statementCase() {
			return getRuleContext(StatementCaseContext.class,0);
		}
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_statement);
		try {
			setState(249);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case ID:
				enterOuterAlt(_localctx, 1);
				{
				setState(243);
				statementAssign();
				}
				break;
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				setState(244);
				statementIf();
				}
				break;
			case T__27:
				enterOuterAlt(_localctx, 3);
				{
				setState(245);
				statementWhile();
				}
				break;
			case T__33:
				enterOuterAlt(_localctx, 4);
				{
				setState(246);
				statementFor();
				}
				break;
			case T__30:
				enterOuterAlt(_localctx, 5);
				{
				setState(247);
				statementRepeat();
				}
				break;
			case T__37:
				enterOuterAlt(_localctx, 6);
				{
				setState(248);
				statementCase();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementAssignContext extends ParserRuleContext {
		public List<VarNameAssignContext> varNameAssign() {
			return getRuleContexts(VarNameAssignContext.class);
		}
		public VarNameAssignContext varNameAssign(int i) {
			return getRuleContext(VarNameAssignContext.class,i);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public StatementAssignContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementAssign; }
	}

	public final StatementAssignContext statementAssign() throws RecognitionException {
		StatementAssignContext _localctx = new StatementAssignContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_statementAssign);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(251);
			varNameAssign();
			setState(256);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,20,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(252);
					match(T__16);
					setState(253);
					varNameAssign();
					}
					} 
				}
				setState(258);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,20,_ctx);
			}
			setState(259);
			match(T__16);
			setState(260);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarNameAssignContext extends ParserRuleContext {
		public VarNameContext varName() {
			return getRuleContext(VarNameContext.class,0);
		}
		public List<TerminalNode> ID() { return getTokens(STParser.ID); }
		public TerminalNode ID(int i) {
			return getToken(STParser.ID, i);
		}
		public VarNameAssignContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varNameAssign; }
	}

	public final VarNameAssignContext varNameAssign() throws RecognitionException {
		VarNameAssignContext _localctx = new VarNameAssignContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_varNameAssign);
		int _la;
		try {
			setState(271);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,22,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(262);
				varName();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(263);
				varName();
				setState(268);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__21) {
					{
					{
					setState(264);
					match(T__21);
					setState(265);
					match(ID);
					}
					}
					setState(270);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementIfContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public List<StatementListContext> statementList() {
			return getRuleContexts(StatementListContext.class);
		}
		public StatementListContext statementList(int i) {
			return getRuleContext(StatementListContext.class,i);
		}
		public StatementIfContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementIf; }
	}

	public final StatementIfContext statementIf() throws RecognitionException {
		StatementIfContext _localctx = new StatementIfContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_statementIf);
		int _la;
		try {
			setState(299);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,25,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(273);
				match(T__22);
				setState(274);
				expression(0);
				setState(275);
				match(T__23);
				setState(276);
				statementList();
				setState(277);
				match(T__24);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(279);
				match(T__22);
				setState(280);
				expression(0);
				setState(281);
				match(T__23);
				setState(282);
				statementList();
				setState(290);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__25) {
					{
					{
					setState(283);
					match(T__25);
					setState(284);
					expression(0);
					setState(285);
					match(T__23);
					setState(286);
					statementList();
					}
					}
					setState(292);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(295);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__26) {
					{
					setState(293);
					match(T__26);
					setState(294);
					statementList();
					}
				}

				setState(297);
				match(T__24);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementWhileContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public StatementListBreakContext statementListBreak() {
			return getRuleContext(StatementListBreakContext.class,0);
		}
		public StatementWhileContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementWhile; }
	}

	public final StatementWhileContext statementWhile() throws RecognitionException {
		StatementWhileContext _localctx = new StatementWhileContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_statementWhile);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(301);
			match(T__27);
			setState(302);
			expression(0);
			setState(303);
			match(T__28);
			setState(304);
			statementListBreak();
			setState(305);
			match(T__29);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementRepeatContext extends ParserRuleContext {
		public StatementListBreakContext statementListBreak() {
			return getRuleContext(StatementListBreakContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public StatementRepeatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementRepeat; }
	}

	public final StatementRepeatContext statementRepeat() throws RecognitionException {
		StatementRepeatContext _localctx = new StatementRepeatContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_statementRepeat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(307);
			match(T__30);
			setState(308);
			statementListBreak();
			setState(309);
			match(T__31);
			setState(310);
			expression(0);
			setState(311);
			match(T__32);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementForContext extends ParserRuleContext {
		public VarNameContext varName() {
			return getRuleContext(VarNameContext.class,0);
		}
		public List<TerminalNode> INTEGER() { return getTokens(STParser.INTEGER); }
		public TerminalNode INTEGER(int i) {
			return getToken(STParser.INTEGER, i);
		}
		public StatementListBreakContext statementListBreak() {
			return getRuleContext(StatementListBreakContext.class,0);
		}
		public StatementForContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementFor; }
	}

	public final StatementForContext statementFor() throws RecognitionException {
		StatementForContext _localctx = new StatementForContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_statementFor);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(313);
			match(T__33);
			setState(314);
			varName();
			setState(315);
			match(T__16);
			setState(316);
			match(INTEGER);
			setState(317);
			match(T__34);
			setState(318);
			match(INTEGER);
			setState(321);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__35) {
				{
				setState(319);
				match(T__35);
				setState(320);
				match(INTEGER);
				}
			}

			setState(323);
			match(T__28);
			setState(324);
			statementListBreak();
			setState(325);
			match(T__36);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementCaseContext extends ParserRuleContext {
		public VarNameContext varName() {
			return getRuleContext(VarNameContext.class,0);
		}
		public CaseItemListContext caseItemList() {
			return getRuleContext(CaseItemListContext.class,0);
		}
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public StatementCaseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementCase; }
	}

	public final StatementCaseContext statementCase() throws RecognitionException {
		StatementCaseContext _localctx = new StatementCaseContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_statementCase);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(327);
			match(T__37);
			setState(328);
			varName();
			setState(329);
			match(T__38);
			setState(330);
			caseItemList();
			setState(333);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__26) {
				{
				setState(331);
				match(T__26);
				setState(332);
				statementList();
				}
			}

			setState(335);
			match(T__39);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CaseItemListContext extends ParserRuleContext {
		public List<CaseItemContext> caseItem() {
			return getRuleContexts(CaseItemContext.class);
		}
		public CaseItemContext caseItem(int i) {
			return getRuleContext(CaseItemContext.class,i);
		}
		public CaseItemListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_caseItemList; }
	}

	public final CaseItemListContext caseItemList() throws RecognitionException {
		CaseItemListContext _localctx = new CaseItemListContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_caseItemList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(340);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==INTEGER) {
				{
				{
				setState(337);
				caseItem();
				}
				}
				setState(342);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CaseItemContext extends ParserRuleContext {
		public TerminalNode INTEGER() { return getToken(STParser.INTEGER, 0); }
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public CaseItemContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_caseItem; }
	}

	public final CaseItemContext caseItem() throws RecognitionException {
		CaseItemContext _localctx = new CaseItemContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_caseItem);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(343);
			match(INTEGER);
			setState(344);
			match(T__5);
			setState(345);
			statementList();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementListBreakContext extends ParserRuleContext {
		public StatementListContext statementList() {
			return getRuleContext(StatementListContext.class,0);
		}
		public TerminalNode LOOP() { return getToken(STParser.LOOP, 0); }
		public StatementListBreakContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statementListBreak; }
	}

	public final StatementListBreakContext statementListBreak() throws RecognitionException {
		StatementListBreakContext _localctx = new StatementListBreakContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_statementListBreak);
		try {
			setState(350);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__22:
			case T__27:
			case T__29:
			case T__30:
			case T__31:
			case T__33:
			case T__36:
			case T__37:
			case ID:
				enterOuterAlt(_localctx, 1);
				{
				setState(347);
				statementList();
				}
				break;
			case LOOP:
				enterOuterAlt(_localctx, 2);
				{
				setState(348);
				match(LOOP);
				setState(349);
				match(T__17);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpressionContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode OPERATOR() { return getToken(STParser.OPERATOR, 0); }
		public TerminalNode NUMERIC() { return getToken(STParser.NUMERIC, 0); }
		public FunctionNameContext functionName() {
			return getRuleContext(FunctionNameContext.class,0);
		}
		public FunctionParamsContext functionParams() {
			return getRuleContext(FunctionParamsContext.class,0);
		}
		public ExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expression; }
	}

	public final ExpressionContext expression() throws RecognitionException {
		return expression(0);
	}

	private ExpressionContext expression(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExpressionContext _localctx = new ExpressionContext(_ctx, _parentState);
		ExpressionContext _prevctx = _localctx;
		int _startState = 56;
		enterRecursionRule(_localctx, 56, RULE_expression, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(365);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__13:
				{
				setState(353);
				match(T__13);
				setState(354);
				expression(0);
				setState(355);
				match(OPERATOR);
				setState(356);
				expression(0);
				setState(357);
				match(T__15);
				}
				break;
			case NUMERIC:
				{
				setState(359);
				match(NUMERIC);
				}
				break;
			case ID:
				{
				setState(360);
				functionName();
				setState(361);
				match(T__13);
				setState(362);
				functionParams();
				setState(363);
				match(T__15);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(372);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,31,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ExpressionContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_expression);
					setState(367);
					if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
					setState(368);
					match(OPERATOR);
					setState(369);
					expression(4);
					}
					} 
				}
				setState(374);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,31,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class FunctionParamsContext extends ParserRuleContext {
		public List<FunctionParamContext> functionParam() {
			return getRuleContexts(FunctionParamContext.class);
		}
		public FunctionParamContext functionParam(int i) {
			return getRuleContext(FunctionParamContext.class,i);
		}
		public FunctionParamsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionParams; }
	}

	public final FunctionParamsContext functionParams() throws RecognitionException {
		FunctionParamsContext _localctx = new FunctionParamsContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_functionParams);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(375);
			functionParam();
			setState(380);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__14) {
				{
				{
				setState(376);
				match(T__14);
				setState(377);
				functionParam();
				}
				}
				setState(382);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionParamContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public VarNameContext varName() {
			return getRuleContext(VarNameContext.class,0);
		}
		public FunctionParamContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionParam; }
	}

	public final FunctionParamContext functionParam() throws RecognitionException {
		FunctionParamContext _localctx = new FunctionParamContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_functionParam);
		try {
			setState(390);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,33,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(383);
				match(ID);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(384);
				match(ID);
				setState(385);
				match(T__16);
				setState(386);
				expression(0);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(387);
				match(ID);
				setState(388);
				match(T__40);
				setState(389);
				varName();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ProgramNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public ProgramNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_programName; }
	}

	public final ProgramNameContext programName() throws RecognitionException {
		ProgramNameContext _localctx = new ProgramNameContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_programName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(392);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public TypeNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeName; }
	}

	public final TypeNameContext typeName() throws RecognitionException {
		TypeNameContext _localctx = new TypeNameContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_typeName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(394);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public FunctionNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionName; }
	}

	public final FunctionNameContext functionName() throws RecognitionException {
		FunctionNameContext _localctx = new FunctionNameContext(_ctx, getState());
		enterRule(_localctx, 66, RULE_functionName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(396);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionBlockNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public FunctionBlockNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionBlockName; }
	}

	public final FunctionBlockNameContext functionBlockName() throws RecognitionException {
		FunctionBlockNameContext _localctx = new FunctionBlockNameContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_functionBlockName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(398);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NsNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public NsNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nsName; }
	}

	public final NsNameContext nsName() throws RecognitionException {
		NsNameContext _localctx = new NsNameContext(_ctx, getState());
		enterRule(_localctx, 70, RULE_nsName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(400);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public EnumNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumName; }
	}

	public final EnumNameContext enumName() throws RecognitionException {
		EnumNameContext _localctx = new EnumNameContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_enumName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(402);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarNameContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public VarNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varName; }
	}

	public final VarNameContext varName() throws RecognitionException {
		VarNameContext _localctx = new VarNameContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_varName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(404);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumValueContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(STParser.ID, 0); }
		public TerminalNode INTEGER() { return getToken(STParser.INTEGER, 0); }
		public EnumValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumValue; }
	}

	public final EnumValueContext enumValue() throws RecognitionException {
		EnumValueContext _localctx = new EnumValueContext(_ctx, getState());
		enterRule(_localctx, 76, RULE_enumValue);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(406);
			_la = _input.LA(1);
			if ( !(_la==ID || _la==INTEGER) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DataTypeContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public FunctionBlockNameContext functionBlockName() {
			return getRuleContext(FunctionBlockNameContext.class,0);
		}
		public ProgramNameContext programName() {
			return getRuleContext(ProgramNameContext.class,0);
		}
		public TerminalNode DT() { return getToken(STParser.DT, 0); }
		public DataTypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_dataType; }
	}

	public final DataTypeContext dataType() throws RecognitionException {
		DataTypeContext _localctx = new DataTypeContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_dataType);
		try {
			setState(412);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,34,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(408);
				typeName();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(409);
				functionBlockName();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(410);
				programName();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(411);
				match(DT);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DataTypeValueContext extends ParserRuleContext {
		public TerminalNode STRING() { return getToken(STParser.STRING, 0); }
		public TerminalNode NUMERIC() { return getToken(STParser.NUMERIC, 0); }
		public DataTypeValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_dataTypeValue; }
	}

	public final DataTypeValueContext dataTypeValue() throws RecognitionException {
		DataTypeValueContext _localctx = new DataTypeValueContext(_ctx, getState());
		enterRule(_localctx, 80, RULE_dataTypeValue);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(414);
			_la = _input.LA(1);
			if ( !(_la==NUMERIC || _la==STRING) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 28:
			return expression_sempred((ExpressionContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expression_sempred(ExpressionContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 3);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3B\u01a3\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\3\2\3\2"+
		"\3\2\3\2\3\2\3\2\5\2[\n\2\3\3\3\3\3\3\7\3`\n\3\f\3\16\3c\13\3\3\3\3\3"+
		"\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3"+
		"\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\7\b\u0083\n\b\f\b\16\b\u0086"+
		"\13\b\3\b\7\b\u0089\n\b\f\b\16\b\u008c\13\b\3\b\3\b\3\t\3\t\3\t\5\t\u0093"+
		"\n\t\3\n\3\n\3\n\3\n\7\n\u0099\n\n\f\n\16\n\u009c\13\n\3\n\3\n\3\n\5\n"+
		"\u00a1\n\n\3\n\3\n\3\13\3\13\3\13\5\13\u00a8\n\13\3\f\3\f\5\f\u00ac\n"+
		"\f\3\r\3\r\3\r\5\r\u00b1\n\r\3\r\3\r\3\16\3\16\7\16\u00b7\n\16\f\16\16"+
		"\16\u00ba\13\16\3\16\3\16\3\17\7\17\u00bf\n\17\f\17\16\17\u00c2\13\17"+
		"\3\20\3\20\7\20\u00c6\n\20\f\20\16\20\u00c9\13\20\3\20\7\20\u00cc\n\20"+
		"\f\20\16\20\u00cf\13\20\3\20\3\20\3\21\3\21\3\21\7\21\u00d6\n\21\f\21"+
		"\16\21\u00d9\13\21\3\21\3\21\3\21\3\21\5\21\u00df\n\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\21\3\21\3\21\5\21\u00ea\n\21\3\21\3\21\5\21\u00ee\n"+
		"\21\3\22\7\22\u00f1\n\22\f\22\16\22\u00f4\13\22\3\23\3\23\3\23\3\23\3"+
		"\23\3\23\5\23\u00fc\n\23\3\24\3\24\3\24\7\24\u0101\n\24\f\24\16\24\u0104"+
		"\13\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\7\25\u010d\n\25\f\25\16\25\u0110"+
		"\13\25\5\25\u0112\n\25\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3"+
		"\26\3\26\3\26\3\26\3\26\3\26\7\26\u0123\n\26\f\26\16\26\u0126\13\26\3"+
		"\26\3\26\5\26\u012a\n\26\3\26\3\26\5\26\u012e\n\26\3\27\3\27\3\27\3\27"+
		"\3\27\3\27\3\30\3\30\3\30\3\30\3\30\3\30\3\31\3\31\3\31\3\31\3\31\3\31"+
		"\3\31\3\31\5\31\u0144\n\31\3\31\3\31\3\31\3\31\3\32\3\32\3\32\3\32\3\32"+
		"\3\32\5\32\u0150\n\32\3\32\3\32\3\33\7\33\u0155\n\33\f\33\16\33\u0158"+
		"\13\33\3\34\3\34\3\34\3\34\3\35\3\35\3\35\5\35\u0161\n\35\3\36\3\36\3"+
		"\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\5\36\u0170\n\36"+
		"\3\36\3\36\3\36\7\36\u0175\n\36\f\36\16\36\u0178\13\36\3\37\3\37\3\37"+
		"\7\37\u017d\n\37\f\37\16\37\u0180\13\37\3 \3 \3 \3 \3 \3 \3 \5 \u0189"+
		"\n \3!\3!\3\"\3\"\3#\3#\3$\3$\3%\3%\3&\3&\3\'\3\'\3(\3(\3)\3)\3)\3)\5"+
		")\u019f\n)\3*\3*\3*\2\3:+\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&"+
		"(*,.\60\62\64\668:<>@BDFHJLNPR\2\4\4\2--<<\4\2\66\66??\2\u01a9\2Z\3\2"+
		"\2\2\4\\\3\2\2\2\6f\3\2\2\2\bl\3\2\2\2\nr\3\2\2\2\fx\3\2\2\2\16\u0080"+
		"\3\2\2\2\20\u0092\3\2\2\2\22\u0094\3\2\2\2\24\u00a4\3\2\2\2\26\u00ab\3"+
		"\2\2\2\30\u00ad\3\2\2\2\32\u00b4\3\2\2\2\34\u00c0\3\2\2\2\36\u00c3\3\2"+
		"\2\2 \u00ed\3\2\2\2\"\u00f2\3\2\2\2$\u00fb\3\2\2\2&\u00fd\3\2\2\2(\u0111"+
		"\3\2\2\2*\u012d\3\2\2\2,\u012f\3\2\2\2.\u0135\3\2\2\2\60\u013b\3\2\2\2"+
		"\62\u0149\3\2\2\2\64\u0156\3\2\2\2\66\u0159\3\2\2\28\u0160\3\2\2\2:\u016f"+
		"\3\2\2\2<\u0179\3\2\2\2>\u0188\3\2\2\2@\u018a\3\2\2\2B\u018c\3\2\2\2D"+
		"\u018e\3\2\2\2F\u0190\3\2\2\2H\u0192\3\2\2\2J\u0194\3\2\2\2L\u0196\3\2"+
		"\2\2N\u0198\3\2\2\2P\u019e\3\2\2\2R\u01a0\3\2\2\2T[\5\4\3\2U[\5\6\4\2"+
		"V[\5\f\7\2W[\5\n\6\2X[\5\16\b\2Y[\5\b\5\2ZT\3\2\2\2ZU\3\2\2\2ZV\3\2\2"+
		"\2ZW\3\2\2\2ZX\3\2\2\2ZY\3\2\2\2[\3\3\2\2\2\\]\7\3\2\2]a\5H%\2^`\5\2\2"+
		"\2_^\3\2\2\2`c\3\2\2\2a_\3\2\2\2ab\3\2\2\2bd\3\2\2\2ca\3\2\2\2de\7\4\2"+
		"\2e\5\3\2\2\2fg\7\5\2\2gh\5@!\2hi\5\34\17\2ij\5\"\22\2jk\7\6\2\2k\7\3"+
		"\2\2\2lm\7\7\2\2mn\5B\"\2no\7\b\2\2op\5\20\t\2pq\7\t\2\2q\t\3\2\2\2rs"+
		"\7\n\2\2st\5F$\2tu\5\34\17\2uv\5\"\22\2vw\7\13\2\2w\13\3\2\2\2xy\7\f\2"+
		"\2yz\5D#\2z{\7\b\2\2{|\5P)\2|}\5\34\17\2}~\5\"\22\2~\177\7\r\2\2\177\r"+
		"\3\2\2\2\u0080\u0084\7\16\2\2\u0081\u0083\7\67\2\2\u0082\u0081\3\2\2\2"+
		"\u0083\u0086\3\2\2\2\u0084\u0082\3\2\2\2\u0084\u0085\3\2\2\2\u0085\u008a"+
		"\3\2\2\2\u0086\u0084\3\2\2\2\u0087\u0089\5 \21\2\u0088\u0087\3\2\2\2\u0089"+
		"\u008c\3\2\2\2\u008a\u0088\3\2\2\2\u008a\u008b\3\2\2\2\u008b\u008d\3\2"+
		"\2\2\u008c\u008a\3\2\2\2\u008d\u008e\7\17\2\2\u008e\17\3\2\2\2\u008f\u0093"+
		"\5\30\r\2\u0090\u0093\5\22\n\2\u0091\u0093\5\32\16\2\u0092\u008f\3\2\2"+
		"\2\u0092\u0090\3\2\2\2\u0092\u0091\3\2\2\2\u0093\21\3\2\2\2\u0094\u0095"+
		"\7\20\2\2\u0095\u009a\5\24\13\2\u0096\u0097\7\21\2\2\u0097\u0099\5\24"+
		"\13\2\u0098\u0096\3\2\2\2\u0099\u009c\3\2\2\2\u009a\u0098\3\2\2\2\u009a"+
		"\u009b\3\2\2\2\u009b\u009d\3\2\2\2\u009c\u009a\3\2\2\2\u009d\u00a0\7\22"+
		"\2\2\u009e\u009f\7\23\2\2\u009f\u00a1\5N(\2\u00a0\u009e\3\2\2\2\u00a0"+
		"\u00a1\3\2\2\2\u00a1\u00a2\3\2\2\2\u00a2\u00a3\7\24\2\2\u00a3\23\3\2\2"+
		"\2\u00a4\u00a7\5J&\2\u00a5\u00a6\7\23\2\2\u00a6\u00a8\5\26\f\2\u00a7\u00a5"+
		"\3\2\2\2\u00a7\u00a8\3\2\2\2\u00a8\25\3\2\2\2\u00a9\u00ac\7<\2\2\u00aa"+
		"\u00ac\5J&\2\u00ab\u00a9\3\2\2\2\u00ab\u00aa\3\2\2\2\u00ac\27\3\2\2\2"+
		"\u00ad\u00b0\5P)\2\u00ae\u00af\7\23\2\2\u00af\u00b1\5R*\2\u00b0\u00ae"+
		"\3\2\2\2\u00b0\u00b1\3\2\2\2\u00b1\u00b2\3\2\2\2\u00b2\u00b3\7\24\2\2"+
		"\u00b3\31\3\2\2\2\u00b4\u00b8\7\25\2\2\u00b5\u00b7\5 \21\2\u00b6\u00b5"+
		"\3\2\2\2\u00b7\u00ba\3\2\2\2\u00b8\u00b6\3\2\2\2\u00b8\u00b9\3\2\2\2\u00b9"+
		"\u00bb\3\2\2\2\u00ba\u00b8\3\2\2\2\u00bb\u00bc\7\26\2\2\u00bc\33\3\2\2"+
		"\2\u00bd\u00bf\5\36\20\2\u00be\u00bd\3\2\2\2\u00bf\u00c2\3\2\2\2\u00c0"+
		"\u00be\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\35\3\2\2\2\u00c2\u00c0\3\2\2"+
		"\2\u00c3\u00c7\7\64\2\2\u00c4\u00c6\7\67\2\2\u00c5\u00c4\3\2\2\2\u00c6"+
		"\u00c9\3\2\2\2\u00c7\u00c5\3\2\2\2\u00c7\u00c8\3\2\2\2\u00c8\u00cd\3\2"+
		"\2\2\u00c9\u00c7\3\2\2\2\u00ca\u00cc\5 \21\2\u00cb\u00ca\3\2\2\2\u00cc"+
		"\u00cf\3\2\2\2\u00cd\u00cb\3\2\2\2\u00cd\u00ce\3\2\2\2\u00ce\u00d0\3\2"+
		"\2\2\u00cf\u00cd\3\2\2\2\u00d0\u00d1\7\17\2\2\u00d1\37\3\2\2\2\u00d2\u00d7"+
		"\5L\'\2\u00d3\u00d4\7\21\2\2\u00d4\u00d6\5L\'\2\u00d5\u00d3\3\2\2\2\u00d6"+
		"\u00d9\3\2\2\2\u00d7\u00d5\3\2\2\2\u00d7\u00d8\3\2\2\2\u00d8\u00da\3\2"+
		"\2\2\u00d9\u00d7\3\2\2\2\u00da\u00db\7\b\2\2\u00db\u00de\5P)\2\u00dc\u00dd"+
		"\7\23\2\2\u00dd\u00df\5R*\2\u00de\u00dc\3\2\2\2\u00de\u00df\3\2\2\2\u00df"+
		"\u00e0\3\2\2\2\u00e0\u00e1\7\24\2\2\u00e1\u00ee\3\2\2\2\u00e2\u00e3\5"+
		"L\'\2\u00e3\u00e4\7\27\2\2\u00e4\u00e5\7,\2\2\u00e5\u00e6\7\b\2\2\u00e6"+
		"\u00e9\5P)\2\u00e7\u00e8\7\23\2\2\u00e8\u00ea\5R*\2\u00e9\u00e7\3\2\2"+
		"\2\u00e9\u00ea\3\2\2\2\u00ea\u00eb\3\2\2\2\u00eb\u00ec\7\24\2\2\u00ec"+
		"\u00ee\3\2\2\2\u00ed\u00d2\3\2\2\2\u00ed\u00e2\3\2\2\2\u00ee!\3\2\2\2"+
		"\u00ef\u00f1\5$\23\2\u00f0\u00ef\3\2\2\2\u00f1\u00f4\3\2\2\2\u00f2\u00f0"+
		"\3\2\2\2\u00f2\u00f3\3\2\2\2\u00f3#\3\2\2\2\u00f4\u00f2\3\2\2\2\u00f5"+
		"\u00fc\5&\24\2\u00f6\u00fc\5*\26\2\u00f7\u00fc\5,\27\2\u00f8\u00fc\5\60"+
		"\31\2\u00f9\u00fc\5.\30\2\u00fa\u00fc\5\62\32\2\u00fb\u00f5\3\2\2\2\u00fb"+
		"\u00f6\3\2\2\2\u00fb\u00f7\3\2\2\2\u00fb\u00f8\3\2\2\2\u00fb\u00f9\3\2"+
		"\2\2\u00fb\u00fa\3\2\2\2\u00fc%\3\2\2\2\u00fd\u0102\5(\25\2\u00fe\u00ff"+
		"\7\23\2\2\u00ff\u0101\5(\25\2\u0100\u00fe\3\2\2\2\u0101\u0104\3\2\2\2"+
		"\u0102\u0100\3\2\2\2\u0102\u0103\3\2\2\2\u0103\u0105\3\2\2\2\u0104\u0102"+
		"\3\2\2\2\u0105\u0106\7\23\2\2\u0106\u0107\5:\36\2\u0107\'\3\2\2\2\u0108"+
		"\u0112\5L\'\2\u0109\u010e\5L\'\2\u010a\u010b\7\30\2\2\u010b\u010d\7-\2"+
		"\2\u010c\u010a\3\2\2\2\u010d\u0110\3\2\2\2\u010e\u010c\3\2\2\2\u010e\u010f"+
		"\3\2\2\2\u010f\u0112\3\2\2\2\u0110\u010e\3\2\2\2\u0111\u0108\3\2\2\2\u0111"+
		"\u0109\3\2\2\2\u0112)\3\2\2\2\u0113\u0114\7\31\2\2\u0114\u0115\5:\36\2"+
		"\u0115\u0116\7\32\2\2\u0116\u0117\5\"\22\2\u0117\u0118\7\33\2\2\u0118"+
		"\u012e\3\2\2\2\u0119\u011a\7\31\2\2\u011a\u011b\5:\36\2\u011b\u011c\7"+
		"\32\2\2\u011c\u0124\5\"\22\2\u011d\u011e\7\34\2\2\u011e\u011f\5:\36\2"+
		"\u011f\u0120\7\32\2\2\u0120\u0121\5\"\22\2\u0121\u0123\3\2\2\2\u0122\u011d"+
		"\3\2\2\2\u0123\u0126\3\2\2\2\u0124\u0122\3\2\2\2\u0124\u0125\3\2\2\2\u0125"+
		"\u0129\3\2\2\2\u0126\u0124\3\2\2\2\u0127\u0128\7\35\2\2\u0128\u012a\5"+
		"\"\22\2\u0129\u0127\3\2\2\2\u0129\u012a\3\2\2\2\u012a\u012b\3\2\2\2\u012b"+
		"\u012c\7\33\2\2\u012c\u012e\3\2\2\2\u012d\u0113\3\2\2\2\u012d\u0119\3"+
		"\2\2\2\u012e+\3\2\2\2\u012f\u0130\7\36\2\2\u0130\u0131\5:\36\2\u0131\u0132"+
		"\7\37\2\2\u0132\u0133\58\35\2\u0133\u0134\7 \2\2\u0134-\3\2\2\2\u0135"+
		"\u0136\7!\2\2\u0136\u0137\58\35\2\u0137\u0138\7\"\2\2\u0138\u0139\5:\36"+
		"\2\u0139\u013a\7#\2\2\u013a/\3\2\2\2\u013b\u013c\7$\2\2\u013c\u013d\5"+
		"L\'\2\u013d\u013e\7\23\2\2\u013e\u013f\7<\2\2\u013f\u0140\7%\2\2\u0140"+
		"\u0143\7<\2\2\u0141\u0142\7&\2\2\u0142\u0144\7<\2\2\u0143\u0141\3\2\2"+
		"\2\u0143\u0144\3\2\2\2\u0144\u0145\3\2\2\2\u0145\u0146\7\37\2\2\u0146"+
		"\u0147\58\35\2\u0147\u0148\7\'\2\2\u0148\61\3\2\2\2\u0149\u014a\7(\2\2"+
		"\u014a\u014b\5L\'\2\u014b\u014c\7)\2\2\u014c\u014f\5\64\33\2\u014d\u014e"+
		"\7\35\2\2\u014e\u0150\5\"\22\2\u014f\u014d\3\2\2\2\u014f\u0150\3\2\2\2"+
		"\u0150\u0151\3\2\2\2\u0151\u0152\7*\2\2\u0152\63\3\2\2\2\u0153\u0155\5"+
		"\66\34\2\u0154\u0153\3\2\2\2\u0155\u0158\3\2\2\2\u0156\u0154\3\2\2\2\u0156"+
		"\u0157\3\2\2\2\u0157\65\3\2\2\2\u0158\u0156\3\2\2\2\u0159\u015a\7<\2\2"+
		"\u015a\u015b\7\b\2\2\u015b\u015c\5\"\22\2\u015c\67\3\2\2\2\u015d\u0161"+
		"\5\"\22\2\u015e\u015f\78\2\2\u015f\u0161\7\24\2\2\u0160\u015d\3\2\2\2"+
		"\u0160\u015e\3\2\2\2\u01619\3\2\2\2\u0162\u0163\b\36\1\2\u0163\u0164\7"+
		"\20\2\2\u0164\u0165\5:\36\2\u0165\u0166\7;\2\2\u0166\u0167\5:\36\2\u0167"+
		"\u0168\7\22\2\2\u0168\u0170\3\2\2\2\u0169\u0170\7\66\2\2\u016a\u016b\5"+
		"D#\2\u016b\u016c\7\20\2\2\u016c\u016d\5<\37\2\u016d\u016e\7\22\2\2\u016e"+
		"\u0170\3\2\2\2\u016f\u0162\3\2\2\2\u016f\u0169\3\2\2\2\u016f\u016a\3\2"+
		"\2\2\u0170\u0176\3\2\2\2\u0171\u0172\f\5\2\2\u0172\u0173\7;\2\2\u0173"+
		"\u0175\5:\36\6\u0174\u0171\3\2\2\2\u0175\u0178\3\2\2\2\u0176\u0174\3\2"+
		"\2\2\u0176\u0177\3\2\2\2\u0177;\3\2\2\2\u0178\u0176\3\2\2\2\u0179\u017e"+
		"\5> \2\u017a\u017b\7\21\2\2\u017b\u017d\5> \2\u017c\u017a\3\2\2\2\u017d"+
		"\u0180\3\2\2\2\u017e\u017c\3\2\2\2\u017e\u017f\3\2\2\2\u017f=\3\2\2\2"+
		"\u0180\u017e\3\2\2\2\u0181\u0189\7-\2\2\u0182\u0183\7-\2\2\u0183\u0184"+
		"\7\23\2\2\u0184\u0189\5:\36\2\u0185\u0186\7-\2\2\u0186\u0187\7+\2\2\u0187"+
		"\u0189\5L\'\2\u0188\u0181\3\2\2\2\u0188\u0182\3\2\2\2\u0188\u0185\3\2"+
		"\2\2\u0189?\3\2\2\2\u018a\u018b\7-\2\2\u018bA\3\2\2\2\u018c\u018d\7-\2"+
		"\2\u018dC\3\2\2\2\u018e\u018f\7-\2\2\u018fE\3\2\2\2\u0190\u0191\7-\2\2"+
		"\u0191G\3\2\2\2\u0192\u0193\7-\2\2\u0193I\3\2\2\2\u0194\u0195\7-\2\2\u0195"+
		"K\3\2\2\2\u0196\u0197\7-\2\2\u0197M\3\2\2\2\u0198\u0199\t\2\2\2\u0199"+
		"O\3\2\2\2\u019a\u019f\5B\"\2\u019b\u019f\5F$\2\u019c\u019f\5@!\2\u019d"+
		"\u019f\7.\2\2\u019e\u019a\3\2\2\2\u019e\u019b\3\2\2\2\u019e\u019c\3\2"+
		"\2\2\u019e\u019d\3\2\2\2\u019fQ\3\2\2\2\u01a0\u01a1\t\3\2\2\u01a1S\3\2"+
		"\2\2%Za\u0084\u008a\u0092\u009a\u00a0\u00a7\u00ab\u00b0\u00b8\u00c0\u00c7"+
		"\u00cd\u00d7\u00de\u00e9\u00ed\u00f2\u00fb\u0102\u010e\u0111\u0124\u0129"+
		"\u012d\u0143\u014f\u0156\u0160\u016f\u0176\u017e\u0188\u019e";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}