function out = findInconsistency(Lt,Lf,Ln,TUcells,IMcells,TUprop,IMprop)   
disp('checking for inconsistency...');

	% perform basic consistency checks...
   c(1) = numel(TUcells) == sum(Lt(:));
   c(2) = numel(TUcells) == numel(TUprop.Pcap);
   c(3) = numel(TUcells) == numel(TUprop.isStem); 
   
   c(4) = numel(TUcells) == numel(TUprop.isa); 
   c(5) = numel(TUcells) == numel(TUprop.isb); 
   c(6) = numel(TUcells) == numel(TUprop.isc); 
   
   c(7) = numel(IMcells) == numel(IMprop.Pcap); 
   c(8) = numel(IMcells) == numel(IMprop.Kcap); 
   c(9) = ~sum(Ln(TUcells));
   c(10) = ~sum(Lt(IMcells));
   c(11) = ~sum(Lf(TUcells)); 
   out = any(~c);
   
   if out % error occured
       disp(c);
   else
	   disp('no problem found');
   end
end