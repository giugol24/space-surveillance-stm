function cost = cost_los_error(params, tle0, obs_times, obs_ra, obs_dec)
    % Cost = mean angular LOS error in RA/Dec [deg]
    % Perche' angolare e non posizione: abbiamo solo misure ottiche
    % RA/Dec, non range. Questa e' la scelta chiave del progetto.
    [ra_model, dec_model] = simulate_trajectory(params, tle0, obs_times);
    dra = wrapToPi(deg2rad(ra_model - obs_ra));
    ddec = deg2rad(dec_model - obs_dec);
    cost = mean(sqrt(dra.^2 + ddec.^2)) * 180/pi;
end
