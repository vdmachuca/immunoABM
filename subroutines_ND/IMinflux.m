function [L,IMcells,IMprop] = IMinflux(L,IMcells,IMprop,IMpmax,IMkmax,IMinflRate)

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
if IMinflRate>0 % if an immune influx is desired
    
if sum(~L(:))>0
    
%place N immune cells in empty locations
[~,coordsNewIMcells] = datasample(L(300:800),IMinflRate,'Replace',false,'Weights',uint8(~L(300:800)));
%[~,coordsNewIMcells] = datasample(L(:),IMinflRate,'Replace',false);

%coordsNewIMcells = length(L); 

L(coordsNewIMcells) = true; % place new cells on grid

nNewCells = numel(coordsNewIMcells); % number of new immune cells
IMcells = [IMcells, coordsNewIMcells]; % add new cells to stack

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMprop.Pcap = [IMprop.Pcap, repmat(IMpmax,1,nNewCells)];  % add properties
IMprop.Kcap = [IMprop.Kcap, repmat(IMkmax,1,nNewCells)];  % add properties
IMprop.engaged = [IMprop.engaged, zeros(1,nNewCells)];    % add properties

IMprop.speca = [IMprop.speca, ones(1,nNewCells)];    % add properties
IMprop.specb = [IMprop.specb, ones(1,nNewCells)];    % add properties

%IMprop.speca = [IMprop.speca, randi([0 1],1,nNewCells)];    % add properties
%IMprop.specb = [IMprop.specb, randi([0 1],1,nNewCells)];    % add properties

%IMprop.speca = [IMprop.speca, ];    % add properties
%IMprop.specb = [IMprop.specb, ];    % add properties


end

end

end