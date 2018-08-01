function [TUcells,TUprop] = shuffleTU(TUcells,TUprop)

shf = randperm(length(TUcells)); % prepare random shuffling
TUcells = TUcells(shf); % randomly shuffle cells -> cells act in random order
TUprop.isStem = TUprop.isStem(shf); % shuffle stemness property accordingly
TUprop.Pcap = TUprop.Pcap(shf); % shuffle Pmax property accordingly

TUprop.isa = TUprop.isa(shf); %shuffle receptor a expression
TUprop.isb = TUprop.isb(shf); %shuffle receptor b expression

TUprop.isc = TUprop.isc(shf); %shuffle receptor c expression

end