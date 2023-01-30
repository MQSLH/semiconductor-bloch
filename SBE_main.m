
%% main file for SBE simulation
clear all

set(0,'DefaultTextInterpreter','tex')

%% Input pulse

% input parameters
pulseLength = 40e-15; %s 100fs = 0.1ps
photonE = 1.409; %eV
% input in atomic units
photonEA = photonE/constantsA.energyEV;
pulseLengthA = pulseLength/constantsA.time;

% create light pulse
input = lightpulse(photonEA,pulseLengthA);
input.plot();

%% k-grid

rBohr = 12.5e-9/constantsA.length; %p.329
nr = 200;
nPhi = 100;

mesh = Kgrid(rBohr,nr,nPhi);

% Solve

sol = SolveSBE(input,mesh);
%%
nK = mesh.nR;
t = sol.x;
P = sol.y(:,1:nK)';

figure(7)
clf
surf(t*constantsA.time,mesh.r/constantsA.length,abs(P),'edgecolor','none')
xlabel('time')
ylabel('r')
zlabel('|P|')














