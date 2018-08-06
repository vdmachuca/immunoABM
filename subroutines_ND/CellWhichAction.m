function [P,D,Mi,C] = CellWhichAction(randI,pprol,pdeath,pmig,change)
%hello=size(randI);
P = randI <= pprol; % GROW: proliferation
D = (randI <= (pdeath+pprol)) & (randI > pprol); % DIE: spontaneous death can happen anytime
Mi = (randI <= (pdeath+pprol+pmig)) &  (randI > (pdeath+pprol)); % GO: migrate if no grow and no die
C = randI <= 0.03; %CHANGE: receptor expression shifts
end

%ah, so these are tests! if an element randI is indeed less than or equal to pprol,
%then the correspomding element of P is 1. otherwise it is 0./ 

%in the future, I would add if statements for receptor expression 