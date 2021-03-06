% JN Kather 2017 (jakob.kather@nct-heidelberg.de)
% inspired by Jan Poleszczuk
% this function can be compiled with the MATLAB code generator

%%%%%%%%% NOTES %%%%%%%%%
%use indxF(currID) to access properties of current cell in the loop
%%%%%%%%% NOTES %%%%%%%%%

function [L, TUcells, TUprop] = TU_go_grow_die_2D( L, nh, TUcells, ...
    TUprop, TUpprol, TUpmig, TUpdeath, TUps)

try
    m = getAdjacent_2D(L,TUcells,nh); % create masks for adjacent positions
catch
    warning('severe error: could not get neighborhood.');
    whos, disp(char(10));
    save SEVERE_ERROR; pause(60);
    warning('error log saved. will continue...');
end

% P, D and Mi are mutually exclusive; Ps and De are dependent on P
% all are either 1 or 0, depending on the conditionals in CellWhichAction.m, which depends on getAdjacent_2D.m

[P,D,Mi,C] = CellWhichAction(m.randI,TUpprol,TUpdeath,TUpmig);

Ps = P & rand(1,m.nC) <= TUps & TUprop.isStem(m.indxF); % symmetric division

De = P & (TUprop.Pcap(m.indxF) == 0); % proliferation capacity exhaution -> Die

del = D | De; % find dead / dying cells; that | is 'or' so del will only be 0 if D=De=0

act = find((P | Mi) & ~del); % live cells that will proliferate or migrate; P=1 or Mi=0, and del=0


for iloop = 1:numel(act) % only for those that will do anything; i.e. not die
    currID = act(iloop); % number within stack of currently acting cell
    ngh = m.S(:,m.indxF(currID)); % cells neighborhood
    ngh2 = ngh(ngh>0); % erasing places that were previously occupied
    indO = find(~L(ngh2),1,'first'); %selecting free spot
    
    
    if ~isempty(indO) % if there is still a free spot
        L(ngh2(indO)) = true; % add cell to grid
        
        if P(currID) % proliferation happens
            newCell = uint32(ngh2(indO)); % find place for new cell
            TUcells = [TUcells, newCell(1)]; % add new cell to stack
            if Ps(currID) % symmetric division
     
               TUprop.isStem = [TUprop.isStem, true];
               TUprop.Pcap = [TUprop.Pcap, TUprop.Pcap(m.indxF(currID))]; 
               
               %like begets like
               TUprop.isa = [TUprop.isa, TUprop.isa(m.indxF(currID))];
               TUprop.isb = [TUprop.isb, TUprop.isb(m.indxF(currID))];
               TUprop.isc = [TUprop.isc, TUprop.isc(m.indxF(currID))];
               
               %like begets like using if statement
%                if  TUprop.isa(m.indxF(currID))
%                    TUprop.isa = [TUprop.isa, true];
%                    TUprop.isb = [TUprop.isb, false];
%                else
%                    TUprop.isa = [TUprop.isa, false];
%                    TUprop.isb = [TUprop.isb, true];
%                end     
               
            else % asymmetric division
                
               TUprop.isStem = [TUprop.isStem, false];
               TUprop.Pcap = [TUprop.Pcap, TUprop.Pcap(m.indxF(currID))-1];
               
               %like begets like
               TUprop.isa = [TUprop.isa, TUprop.isa(m.indxF(currID))];
               TUprop.isb = [TUprop.isb, TUprop.isb(m.indxF(currID))];
               TUprop.isc = [TUprop.isc, TUprop.isc(m.indxF(currID))];
                   
               if ~TUprop.isStem(m.indxF(currID)) % reduce proliferation capacity
                TUprop.Pcap(m.indxF(currID)) = TUprop.Pcap(m.indxF(currID))-1;
               end
               
               %like begets like using if statement 
%                if  TUprop.isa(m.indxF(currID)) 
%                    TUprop.isa = [TUprop.isa, true];
%                    TUprop.isb = [TUprop.isb, false];
%                else
%                    TUprop.isa = [TUprop.isa, false];
%                    TUprop.isb = [TUprop.isb, true];
%                end  
               
            end
        else % migration
            L(TUcells(m.indxF(currID))) = false; % freeing spot
            TUcells(m.indxF(currID)) = uint32(ngh2(indO)); % update cell position
        end
    end
    %%%%%%% CHANGE in receptor expression
    % change occurs in every iteration, doesn't matter if there are empty spots 
        
    if C(currID)
        if TUprop.isa(m.indxF(currID))
            TUprop.isa(m.indxF(currID))=0;
            TUprop.isb(m.indxF(currID))=(randi([0 1]));
            TUprop.isc(m.indxF(currID))=1 - TUprop.isb(m.indxF(currID));
        elseif TUprop.isb(m.indxF(currID))
            TUprop.isb(m.indxF(currID))=0;
            TUprop.isc(m.indxF(currID))=(randi([0 1]));
            TUprop.isa(m.indxF(currID))=1 - TUprop.isc(m.indxF(currID));
        else
            TUprop.isc(m.indxF(currID))=0;
            TUprop.isa(m.indxF(currID))=(randi([0 1]));
            TUprop.isb(m.indxF(currID))=1 - TUprop.isa(m.indxF(currID));
        end
    end
        
    %%%%%%%   
end

if ~isempty(del) % remove dead tumor cells
    L(TUcells(m.indxF(del))) = false;      % first, remove from grid
    [TUcells,TUprop] = removeTU(TUcells,TUprop,m.indxF(del)); % second, remove from stack
end 
end
