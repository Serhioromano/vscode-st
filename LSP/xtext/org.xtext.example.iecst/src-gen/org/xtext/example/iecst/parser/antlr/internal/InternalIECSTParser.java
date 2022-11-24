package org.xtext.example.iecst.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import org.xtext.example.iecst.services.IECSTGrammarAccess;



import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalIECSTParser extends AbstractInternalAntlrParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "RULE_ID", "RULE_INT", "RULE_STRING", "RULE_ML_COMMENT", "RULE_SL_COMMENT", "RULE_WS", "RULE_ANY_OTHER", "'PROGRAM'", "'END_PROGRAM'", "'FUNCTION_BLOCK'", "'END_FUNCTION_BLOCK'", "'FUNCTION'", "':'", "'END_FUNCTION'", "'TYPE'", "'END_TYPE'", "'BOOL'", "'SINT'", "'USINT'", "'INT'", "'UINT'", "'DINT'", "'UDINT'", "'LINT'", "'ULINT'", "'REAL'", "'LREAL'", "'TIME'", "'TOD'", "'DT'", "'BYTE'", "'WORD'", "'DWORD'"
    };
    public static final int RULE_STRING=6;
    public static final int RULE_SL_COMMENT=8;
    public static final int T__19=19;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int T__17=17;
    public static final int T__18=18;
    public static final int T__11=11;
    public static final int T__33=33;
    public static final int T__12=12;
    public static final int T__34=34;
    public static final int T__13=13;
    public static final int T__35=35;
    public static final int T__14=14;
    public static final int T__36=36;
    public static final int EOF=-1;
    public static final int T__30=30;
    public static final int T__31=31;
    public static final int T__32=32;
    public static final int RULE_ID=4;
    public static final int RULE_WS=9;
    public static final int RULE_ANY_OTHER=10;
    public static final int T__26=26;
    public static final int T__27=27;
    public static final int T__28=28;
    public static final int RULE_INT=5;
    public static final int T__29=29;
    public static final int T__22=22;
    public static final int RULE_ML_COMMENT=7;
    public static final int T__23=23;
    public static final int T__24=24;
    public static final int T__25=25;
    public static final int T__20=20;
    public static final int T__21=21;

    // delegates
    // delegators


        public InternalIECSTParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public InternalIECSTParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return InternalIECSTParser.tokenNames; }
    public String getGrammarFileName() { return "InternalIECST.g"; }



     	private IECSTGrammarAccess grammarAccess;

        public InternalIECSTParser(TokenStream input, IECSTGrammarAccess grammarAccess) {
            this(input);
            this.grammarAccess = grammarAccess;
            registerRules(grammarAccess.getGrammar());
        }

        @Override
        protected String getFirstRuleName() {
        	return "Model";
       	}

       	@Override
       	protected IECSTGrammarAccess getGrammarAccess() {
       		return grammarAccess;
       	}




    // $ANTLR start "entryRuleModel"
    // InternalIECST.g:64:1: entryRuleModel returns [EObject current=null] : iv_ruleModel= ruleModel EOF ;
    public final EObject entryRuleModel() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleModel = null;


        try {
            // InternalIECST.g:64:46: (iv_ruleModel= ruleModel EOF )
            // InternalIECST.g:65:2: iv_ruleModel= ruleModel EOF
            {
             newCompositeNode(grammarAccess.getModelRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleModel=ruleModel();

            state._fsp--;

             current =iv_ruleModel; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleModel"


    // $ANTLR start "ruleModel"
    // InternalIECST.g:71:1: ruleModel returns [EObject current=null] : ( ( (lv_programs_0_0= ruleProgram ) ) | ( (lv_functions_1_0= ruleFunction ) ) | ( (lv_functionb_2_0= ruleFunctionBlock ) ) | ( (lv_types_3_0= ruleType ) ) )* ;
    public final EObject ruleModel() throws RecognitionException {
        EObject current = null;

        EObject lv_programs_0_0 = null;

        EObject lv_functions_1_0 = null;

        EObject lv_functionb_2_0 = null;

        EObject lv_types_3_0 = null;



        	enterRule();

        try {
            // InternalIECST.g:77:2: ( ( ( (lv_programs_0_0= ruleProgram ) ) | ( (lv_functions_1_0= ruleFunction ) ) | ( (lv_functionb_2_0= ruleFunctionBlock ) ) | ( (lv_types_3_0= ruleType ) ) )* )
            // InternalIECST.g:78:2: ( ( (lv_programs_0_0= ruleProgram ) ) | ( (lv_functions_1_0= ruleFunction ) ) | ( (lv_functionb_2_0= ruleFunctionBlock ) ) | ( (lv_types_3_0= ruleType ) ) )*
            {
            // InternalIECST.g:78:2: ( ( (lv_programs_0_0= ruleProgram ) ) | ( (lv_functions_1_0= ruleFunction ) ) | ( (lv_functionb_2_0= ruleFunctionBlock ) ) | ( (lv_types_3_0= ruleType ) ) )*
            loop1:
            do {
                int alt1=5;
                switch ( input.LA(1) ) {
                case 11:
                    {
                    alt1=1;
                    }
                    break;
                case 15:
                    {
                    alt1=2;
                    }
                    break;
                case 13:
                    {
                    alt1=3;
                    }
                    break;
                case 18:
                    {
                    alt1=4;
                    }
                    break;

                }

                switch (alt1) {
            	case 1 :
            	    // InternalIECST.g:79:3: ( (lv_programs_0_0= ruleProgram ) )
            	    {
            	    // InternalIECST.g:79:3: ( (lv_programs_0_0= ruleProgram ) )
            	    // InternalIECST.g:80:4: (lv_programs_0_0= ruleProgram )
            	    {
            	    // InternalIECST.g:80:4: (lv_programs_0_0= ruleProgram )
            	    // InternalIECST.g:81:5: lv_programs_0_0= ruleProgram
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getProgramsProgramParserRuleCall_0_0());
            	    				
            	    pushFollow(FOLLOW_3);
            	    lv_programs_0_0=ruleProgram();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"programs",
            	    						lv_programs_0_0,
            	    						"org.xtext.example.iecst.IECST.Program");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }


            	    }
            	    break;
            	case 2 :
            	    // InternalIECST.g:99:3: ( (lv_functions_1_0= ruleFunction ) )
            	    {
            	    // InternalIECST.g:99:3: ( (lv_functions_1_0= ruleFunction ) )
            	    // InternalIECST.g:100:4: (lv_functions_1_0= ruleFunction )
            	    {
            	    // InternalIECST.g:100:4: (lv_functions_1_0= ruleFunction )
            	    // InternalIECST.g:101:5: lv_functions_1_0= ruleFunction
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getFunctionsFunctionParserRuleCall_1_0());
            	    				
            	    pushFollow(FOLLOW_3);
            	    lv_functions_1_0=ruleFunction();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"functions",
            	    						lv_functions_1_0,
            	    						"org.xtext.example.iecst.IECST.Function");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }


            	    }
            	    break;
            	case 3 :
            	    // InternalIECST.g:119:3: ( (lv_functionb_2_0= ruleFunctionBlock ) )
            	    {
            	    // InternalIECST.g:119:3: ( (lv_functionb_2_0= ruleFunctionBlock ) )
            	    // InternalIECST.g:120:4: (lv_functionb_2_0= ruleFunctionBlock )
            	    {
            	    // InternalIECST.g:120:4: (lv_functionb_2_0= ruleFunctionBlock )
            	    // InternalIECST.g:121:5: lv_functionb_2_0= ruleFunctionBlock
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getFunctionbFunctionBlockParserRuleCall_2_0());
            	    				
            	    pushFollow(FOLLOW_3);
            	    lv_functionb_2_0=ruleFunctionBlock();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"functionb",
            	    						lv_functionb_2_0,
            	    						"org.xtext.example.iecst.IECST.FunctionBlock");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }


            	    }
            	    break;
            	case 4 :
            	    // InternalIECST.g:139:3: ( (lv_types_3_0= ruleType ) )
            	    {
            	    // InternalIECST.g:139:3: ( (lv_types_3_0= ruleType ) )
            	    // InternalIECST.g:140:4: (lv_types_3_0= ruleType )
            	    {
            	    // InternalIECST.g:140:4: (lv_types_3_0= ruleType )
            	    // InternalIECST.g:141:5: lv_types_3_0= ruleType
            	    {

            	    					newCompositeNode(grammarAccess.getModelAccess().getTypesTypeParserRuleCall_3_0());
            	    				
            	    pushFollow(FOLLOW_3);
            	    lv_types_3_0=ruleType();

            	    state._fsp--;


            	    					if (current==null) {
            	    						current = createModelElementForParent(grammarAccess.getModelRule());
            	    					}
            	    					add(
            	    						current,
            	    						"types",
            	    						lv_types_3_0,
            	    						"org.xtext.example.iecst.IECST.Type");
            	    					afterParserOrEnumRuleCall();
            	    				

            	    }


            	    }


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleModel"


    // $ANTLR start "entryRuleProgram"
    // InternalIECST.g:162:1: entryRuleProgram returns [EObject current=null] : iv_ruleProgram= ruleProgram EOF ;
    public final EObject entryRuleProgram() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleProgram = null;


        try {
            // InternalIECST.g:162:48: (iv_ruleProgram= ruleProgram EOF )
            // InternalIECST.g:163:2: iv_ruleProgram= ruleProgram EOF
            {
             newCompositeNode(grammarAccess.getProgramRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleProgram=ruleProgram();

            state._fsp--;

             current =iv_ruleProgram; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleProgram"


    // $ANTLR start "ruleProgram"
    // InternalIECST.g:169:1: ruleProgram returns [EObject current=null] : (otherlv_0= 'PROGRAM' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_PROGRAM' ) ;
    public final EObject ruleProgram() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;
        Token otherlv_2=null;


        	enterRule();

        try {
            // InternalIECST.g:175:2: ( (otherlv_0= 'PROGRAM' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_PROGRAM' ) )
            // InternalIECST.g:176:2: (otherlv_0= 'PROGRAM' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_PROGRAM' )
            {
            // InternalIECST.g:176:2: (otherlv_0= 'PROGRAM' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_PROGRAM' )
            // InternalIECST.g:177:3: otherlv_0= 'PROGRAM' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_PROGRAM'
            {
            otherlv_0=(Token)match(input,11,FOLLOW_4); 

            			newLeafNode(otherlv_0, grammarAccess.getProgramAccess().getPROGRAMKeyword_0());
            		
            // InternalIECST.g:181:3: ( (lv_name_1_0= RULE_ID ) )
            // InternalIECST.g:182:4: (lv_name_1_0= RULE_ID )
            {
            // InternalIECST.g:182:4: (lv_name_1_0= RULE_ID )
            // InternalIECST.g:183:5: lv_name_1_0= RULE_ID
            {
            lv_name_1_0=(Token)match(input,RULE_ID,FOLLOW_5); 

            					newLeafNode(lv_name_1_0, grammarAccess.getProgramAccess().getNameIDTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getProgramRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.ID");
            				

            }


            }

            otherlv_2=(Token)match(input,12,FOLLOW_2); 

            			newLeafNode(otherlv_2, grammarAccess.getProgramAccess().getEND_PROGRAMKeyword_2());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleProgram"


    // $ANTLR start "entryRuleFunctionBlock"
    // InternalIECST.g:207:1: entryRuleFunctionBlock returns [EObject current=null] : iv_ruleFunctionBlock= ruleFunctionBlock EOF ;
    public final EObject entryRuleFunctionBlock() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleFunctionBlock = null;


        try {
            // InternalIECST.g:207:54: (iv_ruleFunctionBlock= ruleFunctionBlock EOF )
            // InternalIECST.g:208:2: iv_ruleFunctionBlock= ruleFunctionBlock EOF
            {
             newCompositeNode(grammarAccess.getFunctionBlockRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleFunctionBlock=ruleFunctionBlock();

            state._fsp--;

             current =iv_ruleFunctionBlock; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleFunctionBlock"


    // $ANTLR start "ruleFunctionBlock"
    // InternalIECST.g:214:1: ruleFunctionBlock returns [EObject current=null] : (otherlv_0= 'FUNCTION_BLOCK' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_FUNCTION_BLOCK' ) ;
    public final EObject ruleFunctionBlock() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;
        Token otherlv_2=null;


        	enterRule();

        try {
            // InternalIECST.g:220:2: ( (otherlv_0= 'FUNCTION_BLOCK' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_FUNCTION_BLOCK' ) )
            // InternalIECST.g:221:2: (otherlv_0= 'FUNCTION_BLOCK' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_FUNCTION_BLOCK' )
            {
            // InternalIECST.g:221:2: (otherlv_0= 'FUNCTION_BLOCK' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_FUNCTION_BLOCK' )
            // InternalIECST.g:222:3: otherlv_0= 'FUNCTION_BLOCK' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_FUNCTION_BLOCK'
            {
            otherlv_0=(Token)match(input,13,FOLLOW_4); 

            			newLeafNode(otherlv_0, grammarAccess.getFunctionBlockAccess().getFUNCTION_BLOCKKeyword_0());
            		
            // InternalIECST.g:226:3: ( (lv_name_1_0= RULE_ID ) )
            // InternalIECST.g:227:4: (lv_name_1_0= RULE_ID )
            {
            // InternalIECST.g:227:4: (lv_name_1_0= RULE_ID )
            // InternalIECST.g:228:5: lv_name_1_0= RULE_ID
            {
            lv_name_1_0=(Token)match(input,RULE_ID,FOLLOW_6); 

            					newLeafNode(lv_name_1_0, grammarAccess.getFunctionBlockAccess().getNameIDTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getFunctionBlockRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.ID");
            				

            }


            }

            otherlv_2=(Token)match(input,14,FOLLOW_2); 

            			newLeafNode(otherlv_2, grammarAccess.getFunctionBlockAccess().getEND_FUNCTION_BLOCKKeyword_2());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleFunctionBlock"


    // $ANTLR start "entryRuleFunction"
    // InternalIECST.g:252:1: entryRuleFunction returns [EObject current=null] : iv_ruleFunction= ruleFunction EOF ;
    public final EObject entryRuleFunction() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleFunction = null;


        try {
            // InternalIECST.g:252:49: (iv_ruleFunction= ruleFunction EOF )
            // InternalIECST.g:253:2: iv_ruleFunction= ruleFunction EOF
            {
             newCompositeNode(grammarAccess.getFunctionRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleFunction=ruleFunction();

            state._fsp--;

             current =iv_ruleFunction; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleFunction"


    // $ANTLR start "ruleFunction"
    // InternalIECST.g:259:1: ruleFunction returns [EObject current=null] : (otherlv_0= 'FUNCTION' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= ':' ( (lv_dtype_3_0= ruleDtypes ) ) otherlv_4= 'END_FUNCTION' ) ;
    public final EObject ruleFunction() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;
        Token otherlv_2=null;
        Token otherlv_4=null;
        AntlrDatatypeRuleToken lv_dtype_3_0 = null;



        	enterRule();

        try {
            // InternalIECST.g:265:2: ( (otherlv_0= 'FUNCTION' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= ':' ( (lv_dtype_3_0= ruleDtypes ) ) otherlv_4= 'END_FUNCTION' ) )
            // InternalIECST.g:266:2: (otherlv_0= 'FUNCTION' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= ':' ( (lv_dtype_3_0= ruleDtypes ) ) otherlv_4= 'END_FUNCTION' )
            {
            // InternalIECST.g:266:2: (otherlv_0= 'FUNCTION' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= ':' ( (lv_dtype_3_0= ruleDtypes ) ) otherlv_4= 'END_FUNCTION' )
            // InternalIECST.g:267:3: otherlv_0= 'FUNCTION' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= ':' ( (lv_dtype_3_0= ruleDtypes ) ) otherlv_4= 'END_FUNCTION'
            {
            otherlv_0=(Token)match(input,15,FOLLOW_4); 

            			newLeafNode(otherlv_0, grammarAccess.getFunctionAccess().getFUNCTIONKeyword_0());
            		
            // InternalIECST.g:271:3: ( (lv_name_1_0= RULE_ID ) )
            // InternalIECST.g:272:4: (lv_name_1_0= RULE_ID )
            {
            // InternalIECST.g:272:4: (lv_name_1_0= RULE_ID )
            // InternalIECST.g:273:5: lv_name_1_0= RULE_ID
            {
            lv_name_1_0=(Token)match(input,RULE_ID,FOLLOW_7); 

            					newLeafNode(lv_name_1_0, grammarAccess.getFunctionAccess().getNameIDTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getFunctionRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.ID");
            				

            }


            }

            otherlv_2=(Token)match(input,16,FOLLOW_8); 

            			newLeafNode(otherlv_2, grammarAccess.getFunctionAccess().getColonKeyword_2());
            		
            // InternalIECST.g:293:3: ( (lv_dtype_3_0= ruleDtypes ) )
            // InternalIECST.g:294:4: (lv_dtype_3_0= ruleDtypes )
            {
            // InternalIECST.g:294:4: (lv_dtype_3_0= ruleDtypes )
            // InternalIECST.g:295:5: lv_dtype_3_0= ruleDtypes
            {

            					newCompositeNode(grammarAccess.getFunctionAccess().getDtypeDtypesParserRuleCall_3_0());
            				
            pushFollow(FOLLOW_9);
            lv_dtype_3_0=ruleDtypes();

            state._fsp--;


            					if (current==null) {
            						current = createModelElementForParent(grammarAccess.getFunctionRule());
            					}
            					set(
            						current,
            						"dtype",
            						lv_dtype_3_0,
            						"org.xtext.example.iecst.IECST.Dtypes");
            					afterParserOrEnumRuleCall();
            				

            }


            }

            otherlv_4=(Token)match(input,17,FOLLOW_2); 

            			newLeafNode(otherlv_4, grammarAccess.getFunctionAccess().getEND_FUNCTIONKeyword_4());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleFunction"


    // $ANTLR start "entryRuleType"
    // InternalIECST.g:320:1: entryRuleType returns [EObject current=null] : iv_ruleType= ruleType EOF ;
    public final EObject entryRuleType() throws RecognitionException {
        EObject current = null;

        EObject iv_ruleType = null;


        try {
            // InternalIECST.g:320:45: (iv_ruleType= ruleType EOF )
            // InternalIECST.g:321:2: iv_ruleType= ruleType EOF
            {
             newCompositeNode(grammarAccess.getTypeRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleType=ruleType();

            state._fsp--;

             current =iv_ruleType; 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleType"


    // $ANTLR start "ruleType"
    // InternalIECST.g:327:1: ruleType returns [EObject current=null] : (otherlv_0= 'TYPE' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_TYPE' ) ;
    public final EObject ruleType() throws RecognitionException {
        EObject current = null;

        Token otherlv_0=null;
        Token lv_name_1_0=null;
        Token otherlv_2=null;


        	enterRule();

        try {
            // InternalIECST.g:333:2: ( (otherlv_0= 'TYPE' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_TYPE' ) )
            // InternalIECST.g:334:2: (otherlv_0= 'TYPE' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_TYPE' )
            {
            // InternalIECST.g:334:2: (otherlv_0= 'TYPE' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_TYPE' )
            // InternalIECST.g:335:3: otherlv_0= 'TYPE' ( (lv_name_1_0= RULE_ID ) ) otherlv_2= 'END_TYPE'
            {
            otherlv_0=(Token)match(input,18,FOLLOW_4); 

            			newLeafNode(otherlv_0, grammarAccess.getTypeAccess().getTYPEKeyword_0());
            		
            // InternalIECST.g:339:3: ( (lv_name_1_0= RULE_ID ) )
            // InternalIECST.g:340:4: (lv_name_1_0= RULE_ID )
            {
            // InternalIECST.g:340:4: (lv_name_1_0= RULE_ID )
            // InternalIECST.g:341:5: lv_name_1_0= RULE_ID
            {
            lv_name_1_0=(Token)match(input,RULE_ID,FOLLOW_10); 

            					newLeafNode(lv_name_1_0, grammarAccess.getTypeAccess().getNameIDTerminalRuleCall_1_0());
            				

            					if (current==null) {
            						current = createModelElement(grammarAccess.getTypeRule());
            					}
            					setWithLastConsumed(
            						current,
            						"name",
            						lv_name_1_0,
            						"org.eclipse.xtext.common.Terminals.ID");
            				

            }


            }

            otherlv_2=(Token)match(input,19,FOLLOW_2); 

            			newLeafNode(otherlv_2, grammarAccess.getTypeAccess().getEND_TYPEKeyword_2());
            		

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleType"


    // $ANTLR start "entryRuleDtypes"
    // InternalIECST.g:365:1: entryRuleDtypes returns [String current=null] : iv_ruleDtypes= ruleDtypes EOF ;
    public final String entryRuleDtypes() throws RecognitionException {
        String current = null;

        AntlrDatatypeRuleToken iv_ruleDtypes = null;


        try {
            // InternalIECST.g:365:46: (iv_ruleDtypes= ruleDtypes EOF )
            // InternalIECST.g:366:2: iv_ruleDtypes= ruleDtypes EOF
            {
             newCompositeNode(grammarAccess.getDtypesRule()); 
            pushFollow(FOLLOW_1);
            iv_ruleDtypes=ruleDtypes();

            state._fsp--;

             current =iv_ruleDtypes.getText(); 
            match(input,EOF,FOLLOW_2); 

            }

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "entryRuleDtypes"


    // $ANTLR start "ruleDtypes"
    // InternalIECST.g:372:1: ruleDtypes returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()] : (kw= 'BOOL' | kw= 'SINT' | kw= 'USINT' | kw= 'INT' | kw= 'UINT' | kw= 'DINT' | kw= 'UDINT' | kw= 'LINT' | kw= 'ULINT' | kw= 'REAL' | kw= 'LREAL' | kw= 'TIME' | kw= 'TOD' | kw= 'DT' | kw= 'BYTE' | kw= 'WORD' | kw= 'DWORD' ) ;
    public final AntlrDatatypeRuleToken ruleDtypes() throws RecognitionException {
        AntlrDatatypeRuleToken current = new AntlrDatatypeRuleToken();

        Token kw=null;


        	enterRule();

        try {
            // InternalIECST.g:378:2: ( (kw= 'BOOL' | kw= 'SINT' | kw= 'USINT' | kw= 'INT' | kw= 'UINT' | kw= 'DINT' | kw= 'UDINT' | kw= 'LINT' | kw= 'ULINT' | kw= 'REAL' | kw= 'LREAL' | kw= 'TIME' | kw= 'TOD' | kw= 'DT' | kw= 'BYTE' | kw= 'WORD' | kw= 'DWORD' ) )
            // InternalIECST.g:379:2: (kw= 'BOOL' | kw= 'SINT' | kw= 'USINT' | kw= 'INT' | kw= 'UINT' | kw= 'DINT' | kw= 'UDINT' | kw= 'LINT' | kw= 'ULINT' | kw= 'REAL' | kw= 'LREAL' | kw= 'TIME' | kw= 'TOD' | kw= 'DT' | kw= 'BYTE' | kw= 'WORD' | kw= 'DWORD' )
            {
            // InternalIECST.g:379:2: (kw= 'BOOL' | kw= 'SINT' | kw= 'USINT' | kw= 'INT' | kw= 'UINT' | kw= 'DINT' | kw= 'UDINT' | kw= 'LINT' | kw= 'ULINT' | kw= 'REAL' | kw= 'LREAL' | kw= 'TIME' | kw= 'TOD' | kw= 'DT' | kw= 'BYTE' | kw= 'WORD' | kw= 'DWORD' )
            int alt2=17;
            switch ( input.LA(1) ) {
            case 20:
                {
                alt2=1;
                }
                break;
            case 21:
                {
                alt2=2;
                }
                break;
            case 22:
                {
                alt2=3;
                }
                break;
            case 23:
                {
                alt2=4;
                }
                break;
            case 24:
                {
                alt2=5;
                }
                break;
            case 25:
                {
                alt2=6;
                }
                break;
            case 26:
                {
                alt2=7;
                }
                break;
            case 27:
                {
                alt2=8;
                }
                break;
            case 28:
                {
                alt2=9;
                }
                break;
            case 29:
                {
                alt2=10;
                }
                break;
            case 30:
                {
                alt2=11;
                }
                break;
            case 31:
                {
                alt2=12;
                }
                break;
            case 32:
                {
                alt2=13;
                }
                break;
            case 33:
                {
                alt2=14;
                }
                break;
            case 34:
                {
                alt2=15;
                }
                break;
            case 35:
                {
                alt2=16;
                }
                break;
            case 36:
                {
                alt2=17;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }

            switch (alt2) {
                case 1 :
                    // InternalIECST.g:380:3: kw= 'BOOL'
                    {
                    kw=(Token)match(input,20,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getBOOLKeyword_0());
                    		

                    }
                    break;
                case 2 :
                    // InternalIECST.g:386:3: kw= 'SINT'
                    {
                    kw=(Token)match(input,21,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getSINTKeyword_1());
                    		

                    }
                    break;
                case 3 :
                    // InternalIECST.g:392:3: kw= 'USINT'
                    {
                    kw=(Token)match(input,22,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getUSINTKeyword_2());
                    		

                    }
                    break;
                case 4 :
                    // InternalIECST.g:398:3: kw= 'INT'
                    {
                    kw=(Token)match(input,23,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getINTKeyword_3());
                    		

                    }
                    break;
                case 5 :
                    // InternalIECST.g:404:3: kw= 'UINT'
                    {
                    kw=(Token)match(input,24,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getUINTKeyword_4());
                    		

                    }
                    break;
                case 6 :
                    // InternalIECST.g:410:3: kw= 'DINT'
                    {
                    kw=(Token)match(input,25,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getDINTKeyword_5());
                    		

                    }
                    break;
                case 7 :
                    // InternalIECST.g:416:3: kw= 'UDINT'
                    {
                    kw=(Token)match(input,26,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getUDINTKeyword_6());
                    		

                    }
                    break;
                case 8 :
                    // InternalIECST.g:422:3: kw= 'LINT'
                    {
                    kw=(Token)match(input,27,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getLINTKeyword_7());
                    		

                    }
                    break;
                case 9 :
                    // InternalIECST.g:428:3: kw= 'ULINT'
                    {
                    kw=(Token)match(input,28,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getULINTKeyword_8());
                    		

                    }
                    break;
                case 10 :
                    // InternalIECST.g:434:3: kw= 'REAL'
                    {
                    kw=(Token)match(input,29,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getREALKeyword_9());
                    		

                    }
                    break;
                case 11 :
                    // InternalIECST.g:440:3: kw= 'LREAL'
                    {
                    kw=(Token)match(input,30,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getLREALKeyword_10());
                    		

                    }
                    break;
                case 12 :
                    // InternalIECST.g:446:3: kw= 'TIME'
                    {
                    kw=(Token)match(input,31,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getTIMEKeyword_11());
                    		

                    }
                    break;
                case 13 :
                    // InternalIECST.g:452:3: kw= 'TOD'
                    {
                    kw=(Token)match(input,32,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getTODKeyword_12());
                    		

                    }
                    break;
                case 14 :
                    // InternalIECST.g:458:3: kw= 'DT'
                    {
                    kw=(Token)match(input,33,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getDTKeyword_13());
                    		

                    }
                    break;
                case 15 :
                    // InternalIECST.g:464:3: kw= 'BYTE'
                    {
                    kw=(Token)match(input,34,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getBYTEKeyword_14());
                    		

                    }
                    break;
                case 16 :
                    // InternalIECST.g:470:3: kw= 'WORD'
                    {
                    kw=(Token)match(input,35,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getWORDKeyword_15());
                    		

                    }
                    break;
                case 17 :
                    // InternalIECST.g:476:3: kw= 'DWORD'
                    {
                    kw=(Token)match(input,36,FOLLOW_2); 

                    			current.merge(kw);
                    			newLeafNode(kw, grammarAccess.getDtypesAccess().getDWORDKeyword_16());
                    		

                    }
                    break;

            }


            }


            	leaveRule();

        }

            catch (RecognitionException re) {
                recover(input,re);
                appendSkippedTokens();
            }
        finally {
        }
        return current;
    }
    // $ANTLR end "ruleDtypes"

    // Delegated rules


 

    public static final BitSet FOLLOW_1 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_2 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_3 = new BitSet(new long[]{0x000000000004A802L});
    public static final BitSet FOLLOW_4 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_5 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_6 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_7 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_8 = new BitSet(new long[]{0x0000001FFFF00000L});
    public static final BitSet FOLLOW_9 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_10 = new BitSet(new long[]{0x0000000000080000L});

}