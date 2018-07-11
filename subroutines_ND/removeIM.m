function [IMcells,IMprop] = removeIM(IMcells,IMprop,idx)

    IMcells(idx) = [];           % remove from stack
    IMprop.Pcap(idx) = [];     % remove Pmax property
    IMprop.Kcap(idx) = [];       % remove Kmax property
    IMprop.engaged(idx) = [];       % remove engagement property
    
    IMprop.speca(idx) = []; % remove specificity property
    IMprop.specb(idx) = []; % remove specificity property
    
end

