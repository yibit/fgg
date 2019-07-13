//rhu@HZHL4 MINGW64 ~/code/go/src/temp/antlr/antlr04
//$ antlr4 -Dlanguage=Go -o parser FG.g4

// FG.g4
grammar FG;


// Keywords

STRUCT: 'struct';
INTERFACE: 'interface';
FUNC: 'func';
RETURN: 'return';
TYPE: 'type';


// Tokens

fragment NAME_START  // LETTER
   : ('a' .. 'z')
   | ('A' .. 'Z')
   /*| '+'
   | '-'
   | '*'
   | '/'
   | '.'*/
   ;

NAME
   : NAME_START (NAME_START | DIGIT)*
   ;

fragment DIGIT
   : ('0' .. '9')
   ;

WHITESPACE: [ \r\n\t]+ -> skip;
COMMENT:            '/*' .*? '*/'    -> channel(HIDDEN);
LINE_COMMENT:       '//' ~[\r\n]*    -> channel(HIDDEN);

// Rules
start : top=expression EOF;

expression
    : variable=NAME                            # Variable
    | typ=NAME '{' args=exprs* '}'  # Lit
    | expr=expression '.' field=NAME      # Select
    | recv=expression '.' meth=NAME '(' args=exprs* ')'  # Call
    | expr=expression '.' '(' typ=NAME ')'        # Assertion
    ;

exprs : expression (',' expression)* ;

//meth_sig : meth=name '(' parms=formal* ')' ret=name # MethSig ;

//formal : var=name type=name # ParamDecl ;
