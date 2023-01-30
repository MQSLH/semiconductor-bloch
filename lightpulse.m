

classdef lightpulse
   % input light pulse for SBE simulation 
   properties (SetAccess=private)
       
       peak % maximum value of the E field
       wavelength %optical wavelength of the pulse
       energy %photon energy of the pulse
       omega %optical angular frequency of the pulse
       envelope %envelope function of the pulse
       E %electric field evaluated at time vector
       time %1000 point linear time vector
       fE %function handle to evaluate E at arbitrary time
   end
    
    
   methods
        
       function this = lightpulse(energy,pulseLength) 
       %this = lightpulse(energy,pulseLength) 
       % Forms a gaussian pulse with given photon energy and pulse length
       % The envelope is gaussian with mean of pulseLength/2 and standard
       % deviation of pulseLength/8
       % INPUT:
       %    energy: photon energy for the pulse in atomic units
       %    pulseLength: 5 sigma time of the gaussian pulse in atomic units
       %    peak: maximum value of the E field in atomic units
       %
       % OUTPUT:
       %    this: lightpulse object
       %
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
       
            this.energy = energy;
            this.wavelength = (constantsA.h*constantsA.c)/energy;
            this.omega = this.energy/constantsA.hbareV;
            
            this.time = linspace(0,pulseLength,1000);
            
            mu = pulseLength/2;
            sigma = max(this.time)/8;
            this.envelope = normpdf(this.time,mu,sigma);
            
            this.E = cos(this.omega*this.time).*this.envelope;
            this.fE = @(t) 0.01*cos(this.omega*t).*normpdf(t,mu,sigma);
       
       end
       

       
       function varargout = plot(this,varargin)
           % plots the pulse E field and envelope
           % creates a plot of the input pulse
           % obj.plot() of plot(obj) plots to figure(1)
           % obj.plot(fig) of plot(obj,fig): where fig is a figure handle
           % plots to fig
       
           switch nargin
               
               case 1 % only self, plot to fig(1)
           
           H.fig = figure(1);
           clf(H.fig);         
           
               case 2 % figure handle as second argument
                   
           H.fig = figure(varargin{1});
           clf(H.fig);
     
               otherwise
                   error('too many arguments');
           end % switch
           
           % plot
           subplot(1,2,1);
           H.ax1 = gca;
           H.p1 = plot(this.time,this.E);
           xlabel('time [a. u.]');
           ylabel('E [a.u.]');
           subplot(1,2,2);
           H.ax2 = gca;
           H.p2 = plot(this.time,this.envelope);
           xlabel('time [a. u.]');
           ylabel('envelope');
           
           varargout{1} = H; 
           
       end % function plot
           
           
   end %methods
       
       
end %classdef
   
   