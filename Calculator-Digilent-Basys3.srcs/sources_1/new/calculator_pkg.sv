package calculator_pkg;
    typedef enum
    {
        CLEAR0,
        CLEAR1,
        OP0,
        OP1,
        ANSWER0,
        ANSWER1
    }
    CalcState;
    
    typedef enum
    {
        ADD,
        SUB,
        MULT,
        DIV
    }
    ALU_Op;
endpackage