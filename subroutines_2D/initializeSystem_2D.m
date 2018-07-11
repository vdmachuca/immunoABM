function [L, TUcells, IMcells, TUprop, IMprop] = initializeSystem_2D(N,M,TUpmax)
    
    % START INITIALIZE GRID  -------------------------------------------
    L = false(N,M);
    % END INITIALIZE GRID  ----------------------------------------------
    
    % START INITIALIZE TUMOR CELLS ------------------------------------------- 
    %initiate multiple tumor cells
    posa =int32(N*round(M/2)-round(N/2));
    posb =int32(N*round(M/2)-round(N/2)+1);
    TUcells = [posa posb]; 
    %TUcells = int32(N*round(M/2)-round(N/2));
    
    %set property of first cells: receptor expression type 
    TUprop.isa = [true false];
    TUprop.isb = [false true];
    
    TUprop.Pcap = [uint8(TUpmax) uint8(TUpmax)]; % set property of first cell: proliferation capacity
    TUprop.isStem = [true true];        % set property of first cell: stemness
    
    %original code: 
    %TUcells = int32(N*round(M/2)-round(N/2)); % first TU cell is centered
    %OG L(TUcells) = true; 			 % place first tumor cell on the grid
    %OG TUprop.isStem = true;        % set property of first cell: stemness
    %OG Uprop.Pcap = uint8(TUpmax); % set property of first cell: proliferation capacity
    
    % END INITIALIZE TUMOR CELLS ---------------------------------------------

    % START INITIALIZE IMMUNE CELLS (LYMPHOCYTES) -----------------------------
    IMcells = int32([]); 	 % preallocate immune cell position vector
    IMprop.Pcap = uint8([]); % add properties: max proliferation capacity
    IMprop.Kcap = uint8([]); % add properties: max killing capacity
    IMprop.engaged = uint8([]); % add properties: engagement in killing
    
    IMprop.speca = uint8([]); %specificity
    IMprop.specb = uint8([]); %specificity
    
     % END INITIALIZE IMMUNE CELLS --------------------------------------------

end