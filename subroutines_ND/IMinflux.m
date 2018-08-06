function [L,IMcells,IMprop] = IMinflux(L,IMcells,IMprop,IMpmax,IMkmax,IMinflRate,i)

% if IMinflRate>0 % if an immune influx is desired
%     
% % if there are empty locations
% if sum(~L(:))>0
% % place N immune cells in empty locations
% [~,coordsNewIMcells] = datasample(L(:),IMinflRate,'Replace',false,'Weights',uint8(~L(:)));
% 
% 
% % InfluxMap = rand(size(L)) <= IMinfluxProb; % find random places
% % InfluxMap(L) = false; % only empty grid cells
% 
% L(coordsNewIMcells) = true; % place new cells on grid
% nNewCells = numel(coordsNewIMcells); % number of new immune cells
% IMcells = [IMcells, coordsNewIMcells]; % add new cells to stack

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%have IMinflRate CARs flow in from the point source
%length(coordsNewIMcells) are added each DAY

if ismember(i,[20,40,60,80])
%if i<15

    if IMinflRate>0 % if an immune influx is desired
        
        if sum(~L(:))>0
            
            %place N immune cells in empty locations
            %[~,coordsNewIMcells] = datasample(L(5000:5500),IMinflRate,'Replace',false,'Weights',uint8(~L(5000:5500)));
            %[~,coordsNewIMcells] = datasample(L(:),IMinflRate,'Replace',false);
            
            %coordsNewIMcells = [30150,30151,30152,30153,30154,30155,30156,30157,30158,30159];
            coordsNewIMcells = 30151:30161;
            %coordsNewIMcells = 30151:30190;
            
            %x = [30150:3016, 29830:29840];
            %coordsNewIMcells = randi([1 numel(x)],1,IMinflRate);
            %coordsNewIMcells = randi([30150 32150],1,IMinflRate);
            
            
            L(coordsNewIMcells) = true; % place new cells on grid
            
            nNewCells = numel(coordsNewIMcells); % number of new immune cells
            IMcells = [IMcells, coordsNewIMcells]; % add new cells to stack
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            IMprop.Pcap = [IMprop.Pcap, repmat(IMpmax,1,nNewCells)];  % add properties
            IMprop.Kcap = [IMprop.Kcap, repmat(IMkmax,1,nNewCells)];  % add properties
            IMprop.engaged = [IMprop.engaged, zeros(1,nNewCells)];    % add properties
            
            %all specific to b
%             IMprop.speca = [IMprop.speca, false(1,nNewCells)];    % add properties
%             IMprop.specb = [IMprop.specb, ones(1,nNewCells)];    % add properties
%             
            %IMprop.speca = [IMprop.speca, randi([0 1],1,nNewCells)];    % add properties
            %IMprop.specb = [IMprop.specb, randi([0 1],1,nNewCells)];    % add properties
            
            %IMprop.speca = [IMprop.speca, ];    % add properties
            %IMprop.specb = [IMprop.specb, ];    % add properties
            
            %half specificity a, half specificity b
            IMprop.speca = [IMprop.speca,[false(1,floor(nNewCells/2)) ones(1,nNewCells-floor(nNewCells/2))]];
            IMprop.specb = [IMprop.specb,[ones(1,floor(nNewCells/2)) false(1,nNewCells-floor(nNewCells/2))]];

       end 
   end
end




