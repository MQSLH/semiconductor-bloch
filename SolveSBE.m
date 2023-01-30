


function sol = SolveSBE(light,mesh)

    nK = mesh.nR;

    
    

    
    me = 0.0665*constantsA.me;
    mh = 0.457*constantsA.me;
    Eg0 = 1.41/constantsA.energyEV;
    
    
    dcv = -(constantsA.q*constantsA.hbareV)/(1.519/constantsA.energyEV) * sqrt((28.8/constantsA.energyEV)/(2*constantsA.me));
    mu = 1/((1/me)+(1/mh));
    e_k1 = ((constantsA.hbar^2*mesh.r.^2)/(2*mu))+Eg0;
    
   
    coulomb = CoulombR(mesh);
    
    figure(2)
    subplot(1,2,1)
    scatter(mesh.X(:),mesh.Y(:));
    subplot(1,2,2)
    surf(mesh.r,mesh.r,coulomb,'edgecolor','none');
    xlabel('k')
    ylabel('k''')
    zlabel('log10 of Coulomb')
    
    % initial state P, fe, fh = 0
    
    nT = 1000;
    tspan = linspace(0,40*max(light.time),nT);
    

    
    options = odeset('RelTol',1e-6,...
                     'AbsTol',1e-6,...
                     'InitialStep',10);%,...
                     %'OutputFcn',@odeOutput);
                 
    yinit = zeros(3*nK,1);
    [t,y] = ode45(@odefun,tspan,yinit,options);
    
    sol.x = t;
    sol.y = y;
    
    function dydt = odefun(t,y)
        
        % 3nK variables and equations
        P = y(1:nK);
        fe = y(nK+1:2*nK);
        fh= y(2*nK+1:end);
        
        % are these needed?
        gammaVC = zeros(nK,1);
        gammaCC = zeros(nK,1);
        gammaVV = zeros(nK,1);
        gammaQEDvc = zeros(nK,1);
        gammaQEDcc = zeros(nK,1);
        gammaQEDvv = zeros(nK,1);
        
        dydt = zeros(3*nK,1);

        Rabi = dcv*light.fE(t)+coulomb*P;
        
        
        e_k = e_k1(:)-coulomb*(fe+fh);
        
        
        dydt(1:nK) = 1/(1i*constantsA.hbareV)*(e_k.*P -(1-fe-fh).*Rabi+gammaVC+gammaQEDvc);
        
        dydt(nK+1:2*nK) = (1/constantsA.hbareV)*2*imag(P.*conj(Rabi)+gammaCC+gammaQEDcc);
        
        dydt(2*nK+1:3*nK) = (1/constantsA.hbareV)*2*imag(P.*conj(Rabi)-gammaVV-gammaQEDvv);
    
    
    

    end


    function status = odeOutput(t,y,flag)
        status = 0;
        
        gui = SBE_plot.GetGUI(y,y,zeros(nK,1),zeros(nK,1));
        
        switch flag
            case 'init'
                
                
            case 'done'
                
            otherwise
                
                P = y(1:nK,1);
                fe = y(nK+1:2*nK,1);
                fh= y(2*nK+1:end,1);

                Rabi = dcv*light.fE(t(1))+coulomb*P;
                e_k = e_k1(:)-coulomb*(fe+fh);

                dydt = odefun(t(1),y(:,1));
                gui.update(y(:,1),t(1),dydt,e_k,Rabi);
        
        end % switch
        
    end % outputFcn

end

