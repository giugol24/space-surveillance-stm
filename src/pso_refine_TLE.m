function [best_params, best_cost, history] = pso_refine_TLE(tle0, obs_times, obs_ra, obs_dec, orbita)
    % PSO local-neighborhood, 6 parametri: [i, RAAN, e, omega, M, n]
    % Bounds giustificati nel README:
    % LEO: +-0.1% - orbita gia' buona, arco corto
    % MEO/GEO: +-5% / +-10% - TLE vecchio, serve esplorare di piu'
    % B* escluso: per archi corti migliora il fit solo marginalmente
    % e destabilizza la soluzione
    
    if strcmp(orbita,'LEO')
        pct = 0.001;
    else
        pct = 0.05;
    end
    
    lb = tle0 .* (1-pct); ub = tle0 .* (1+pct);
    
    options = optimoptions('particleswarm', ...
        'SwarmSize', 80, 'MaxIterations', 200, ...
        'InertiaRange', [0.4 1.0], ...
        'SocialAdjustment', 0.5, 'SelfAdjustment', 0.5, ...
        'MinNeighborsFraction', 0.1, ...
        'FunctionTolerance', 1e-4);
    
    % ... chiamata a particleswarm con @cost_los_error
end
