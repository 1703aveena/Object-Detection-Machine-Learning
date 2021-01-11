function [ap, prec, rec] =Question_4_4_1()
    [trD, trLb, valD, valLb, trRegs, valRegs] = HW4_Utils.getPosAndRandomNeg();
    
    [alpha, W, b] = Quadprogram(trD, trLb, C);
    disp(size(W));
    disp(size(b));
    HW4_Utils.genRsltFile(W, b, 'val', 'C:/Users/AVEENA/ML/hw4/Output_4_4_1');
    [ap, prec, rec] = HW4_Utils.cmpAP('C:/Users/AVEENA/ML/hw4/Output_4_4_1', 'val');
    ap
    prec
    rec
end