function [L, TUcells, IMcells, TUprop, IMprop] = initializeSystem_2D(N,M,TUpmax)
    
    % START INITIALIZE GRID  -------------------------------------------
    L = false(N,M);
    % END INITIALIZE GRID  ----------------------------------------------
    
    % START INITIALIZE TUMOR CELLS -------------------------------------------
    TUcells = int32(N*round(M/2)-round(N/2)); % first TU cell is centered
    
    %initiate multiple tumor cells
    %posa =int32(N*round(M/2)-round(N/2));
    %posa =int32(N*round(M/2)-round(N/2)+1);
    %posa =int32(N*round(M/2)-round(N/2)-1);
    %posa =int32(N*round(M/2)-round(N/2)+N);
    %posa =int32(N*round(M/2)-round(N/2)-N);
    %posa =int32(N*round(M/2)-round(N/2)+N+1);
    %TUcells = [posa posb posc posab posbc posac]; 
    
    %set property of first cells: receptor expression type 
    %TUprop.isa = true; 
    %TUprop.isb = true; 
    %TUprop.isc = true; 
    %TUprop.isab = true; 
    %TUprop.isbc = true; 
    %TUprop.isac = true; 
    
    
    L(TUcells) = true; 			 % place first tumor cell on the grid
    TUprop.isStem = true;        % set property of first cell: stemness
    TUprop.Pcap = uint8(TUpmax); % set property of first cell: proliferation capacity
    
    % END INITIALIZE TUMOR CELLS ---------------------------------------------

    % START INITIALIZE IMMUNE CELLS (LYMPHOCYTES) -----------------------------
    IMcells = int32([]); 	 % preallocate immune cell position vector
    IMprop.Pcap = uint8([]); % add properties: max proliferation capacity
    IMprop.Kcap = uint8([]); % add properties: max killing capacity
    IMprop.engaged = uint8([]); % add properties: engagement in killing
     % END INITIALIZE IMMUNE CELLS --------------------------------------------

end