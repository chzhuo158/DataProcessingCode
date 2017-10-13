% energy calibration
%channel = [346,650,693,708];
%energy = [511,1170,1275,1330];
%plot(channel,energy)
function Y=cz_EnergyCalibration(X)
 %p1=2.2218;
 %p2 = -253.4;
 %Y = p1*X + p2;
 
 
       p1 =   1.205e-06   ;
       p2 =    0.001011  ;
       p3 =       0.007319 ;
     Y = p1*(X.^2) + p2*X + p3;


 
