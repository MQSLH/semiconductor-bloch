

classdef constantsA < handle
    % constantsA Natural constants and conversion factors in Hartree atomic units
    
    
   properties (Constant)
       %% Natural constants
       
       heV = 2*pi; %planck constant
       h = 2*pi; %planck constant
       hbar = 1; %reduced planck constant
       hbareV = 1; %reduced planck constant
       
       c = 137.03599; %speed of light in vacuum
       me = 1; %electron mass
       e_0 = 1/(4*pi); %vacuum permittivity
       mu_0 = 4*pi*(1/137.03599)^2; %vacuum permeability
       T = 300; %temperature
       q = 1; %elementary charge
       
       %% Units
       % example: 1 meter in atomic units = 1/constantsA.length
       % 1 atomic unit length = constantsA.length meters
       
       length = 5.2917721092e-11; %m
       energy = 4.35974417e-18; %J
       energyEV = 27.211385; %eV
       time = 2.418884326505e-17; %s
       EField = 5.14220652e11; %V/m
       
       
       
   end 
   
       
  
   
   
   
end