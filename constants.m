

classdef constants < handle
    % constants Natural constants in SI units
    
   properties (Constant)
       heV = 4.135667662e-15; %planck constant, eV*s
       h = 6.626070040e-34; %planck constant, J*s
       hbar = 1.05457180e-34;
       hbareV = 6.582119514e-16;
       c = 299792458; %speed of light in vacuum, m s-1
       me = 9.10938356e-31; %electron mass, kg
       e_0 = 8.854187817e-12; %vacuum permittivity, F*m-1
       mu_0 = pi*4e-7; %vacuum permeability, H*m-1
       kB = 8.6173303e-5; %boltzmann conctant, eV/K
       T = 300; %temperature, K
       VThermal = 0.025851990900000; %thermal voltage
       q = 1.602176620e-19; %elementary charge, C
       E0SHE = -4.44; %Potential of standard hydrogen electrode against vacuum
   end   
end