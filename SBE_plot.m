    
classdef SBE_plot < handle
    
    
    
    properties
        
        fig
        ax
        titleax
        title
    end
        


     methods (Static)
       

      function singleObj = GetGUI(y,dydt,e_k,Rabi)
          % Public access costructor interface. Generates persistent local 
          % object only if one does not exist, and returns the handle to the object
          %
          % INPUT:
          %   parameterList - peccellParameters object
          %   loopData - peccellLoop object
          %   guiCallbacks - handles to callback functions outside the
          %   class
          % OUTPUT:
          %   singleObj - persistent instance of the class. If local
          %   instance already exists when GetGUI() is called, handle to
          %   it is returned. Otherwise a new object is created
         persistent localObj
             if isempty(localObj) || ~isvalid(localObj)
                localObj = SBE_plot(y,dydt,e_k,Rabi);
             end
            singleObj = localObj;
      end
        
        
        
    end
    
    
    
    
    methods (Access = private)
        
        function this = SBE_plot(y,dydt,e_k,Rabi)
        
            
        nK = length(y)/3;  
            
        P = y(1:nK);
        fe = y(nK+1:2*nK);
        fh= y(2*nK+1:end);
        
        
  
        
        this.fig = figure(3);
        clf;
        
        

        
        
        
        this.ax = subplot(3,3,1);
        hold on
        plot(1:nK,real(y(1:nK)),'linewidth',2);
        plot(1:nK,imag(y(1:nK)),'linewidth',2);
        hold off
        ylabel('P');

        this.ax(2) = subplot(3,3,2);
        plot(1:nK,abs(y(nK+1:2*nK)));
        ylabel('fe');

        this.ax(3) = subplot(3,3,3);
        plot(1:nK,abs(y(2*nK+1:3*nK)));
        ylabel('fh');

        this.ax(4) = subplot(3,3,4);
        
        hold on
        plot(1:nK,real(dydt(1:nK)),'linewidth',2);
        plot(1:nK,imag(dydt(1:nK)),'linewidth',2);
        hold off
        ylabel('dPdt');

        this.ax(5) = subplot(3,3,5);
        plot(1:nK,abs(dydt(nK+1:2*nK)));
        ylabel('dfedt');

        this.ax(6) = subplot(3,3,6);
        plot(1:nK,abs(dydt(2*nK+1:3*nK)));
        ylabel('dfhdt');

        this.ax(7) = subplot(3,3,7);
        hold on
        plot(1:nK,real(1/(1i*constantsA.hbareV)*(e_k.*P)));
        plot(1:nK,imag(1/(1i*constantsA.hbareV)*(e_k.*P)));
        hold off
        ylabel('e_kP');

        this.ax(8) = subplot(3,3,8);

        hold on
        plot(1:nK,real(1/(1i*constantsA.hbareV)*((1-fe-fh).*Rabi)),'linewidth',2);
        plot(1:nK,imag(1/(1i*constantsA.hbareV)*((1-fe-fh).*Rabi)),'linewidth',2);
        hold off
        ylabel('Rabi');

        this.ax(9) = subplot(3,3,9);
        plot(1:nK,abs(dydt(2*nK+1:3*nK)));
        ylabel('dfhdt');
    
   
        
        
        this.titleax = axes('Parent', this.fig,...
                      'Units', 'normalized',...
                      'Position',[0 0 1 1],...
                      'Visible','off');
        
        
        this.title = text(this.titleax,0.45,0.94,'','FontSize',20);
        
        end %constructor
    end
    
    methods
    
        function update(obj,y,t,dydt,e_k,Rabi)
        
        nK = length(y)/3;  
            
        P = y(1:nK);
        fe = y(nK+1:2*nK);
        fh= y(2*nK+1:end);
            
        titles = sprintf('T = %.1f',t);
        obj.title.String = titles;    
            
        plots = obj.ax(1).Children;    
        plots(1).YData = real(y(1:nK)); 
        plots(2).YData = imag(y(1:nK));

        plots = obj.ax(2).Children;    
        plots(1).YData = y(nK+1:2*nK);

        plots = obj.ax(3).Children;    
        plots(1).YData = y(2*nK+1:3*nK);

        
        plots = obj.ax(4).Children;  
        plots(1).YData = real(dydt(1:nK)); 
        plots(2).YData = imag(dydt(1:nK));
        
        
        plots = obj.ax(5).Children;    
        plots(1).YData = dydt(nK+1:2*nK);       

        
        plots = obj.ax(6).Children;    
        plots(1).YData = dydt(2*nK+1:3*nK);       


        
        plots = obj.ax(7).Children;    
        plots(1).YData = real(1/(1i*constantsA.hbareV)*(e_k.*P));
        plots(2).YData = imag(1/(1i*constantsA.hbareV)*(e_k.*P));

        
        plots = obj.ax(8).Children;    
        plots(1).YData =  real(1/(1i*constantsA.hbareV)*((1-fe-fh).*Rabi));
        plots(2).YData =  imag(1/(1i*constantsA.hbareV)*((1-fe-fh).*Rabi));
        
        drawnow;    
            
        end
        
        
        
        
    end % methods
    
end%class