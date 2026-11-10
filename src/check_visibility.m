function [is_visible, el_deg] = check_visibility(r_sat_eci, r_obs_eci, r_sun_eci)
    % Criteri da Collepardo, come nel README:
    % - Mask 30 deg
    % - Notte locale (Sole sotto -12 deg)
    % - Satellite illuminato (non in ombra terrestre)
    % Nessun path assoluto, solo vettori in input
    
    el_deg = elevation_angle(r_sat_eci, r_obs_eci);
    
    is_night = sun_elevation(r_obs_eci, r_sun_eci) < -12;
    is_illuminated = ~is_in_earth_shadow(r_sat_eci, r_sun_eci);
    
    is_visible = (el_deg > 30) && is_night && is_illuminated;
end
