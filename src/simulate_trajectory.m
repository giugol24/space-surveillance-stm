function [ra_deg, dec_deg] = simulate_trajectory(params, tle0, obs_times)
    % Simula RA/Dec da parametri orbitali ottimizzati
    % Input:
    %   params: [i, RAAN, e, omega, M, n] - 6 parametri PSO
    %   tle0: TLE di riferimento [i, RAAN, e, omega, M, n]
    %   obs_times: vettore datetime osservazioni
    % Output:
    %   ra_deg, dec_deg: coordinate topocentriche da Collepardo
    %
    % Nota: questa funzione NON contiene path assoluti.
    % La propagazione SGP4 e' in sgp4Prop() - libreria esterna Celestrak.
    % Qui mostriamo solo la catena: params -> SGP4 -> ECI -> RA/Dec
    
    % 1. Costruisci satrec da params (stessa struttura del TLE originale)
    satrec = tle0;
    satrec.inclo = params(1);
    satrec.nodeo = params(2);
    satrec.ecco  = params(3);
    satrec.argpo = params(4);
    satrec.mo    = params(5);
    satrec.no    = params(6);
    
    % 2. Osservatorio: Collepardo (FR) - coordinate fisse
    lat_obs = deg2rad(41.7605);
    lon_obs = deg2rad(13.3678);
    alt_obs = 0.59; % km
    
    n_obs = length(obs_times);
    ra_deg = zeros(n_obs, 1);
    dec_deg = zeros(n_obs, 1);
    
    for k = 1:n_obs
        % Tempo dal epoch in minuti
        tsince = minutes(obs_times(k) - tle0.epoch);
        
        % 3. SGP4: ECI position [km]
        [~, r_eci, ~] = sgp4Prop(satrec, tsince);
        
        % 4. ECI -> Topocentrico -> RA/Dec
        [ra_deg(k), dec_deg(k)] = eci2radec(r_eci, lat_obs, lon_obs, alt_obs, obs_times(k));
    end
end
