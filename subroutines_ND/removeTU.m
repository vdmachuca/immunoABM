function [TUcells,TUprop] = removeTU(TUcells,TUprop,idx)

    TUcells(idx) = [];           % remove from stack
    TUprop.isStem(idx) = [];     % remove stemness property
    TUprop.Pcap(idx) = [];       % remove Pmax property
    
    TUprop.isa(idx) = []; %remove receptor expression 
    TUprop.isb(idx) = [];
    
end