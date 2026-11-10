% Esempio: Visibility Planning da Collepardo
% Riproduce Parte 1 del progetto - come nel README
%
% Come usarlo:
% 1. Metti le funzioni SGP4 in src/sgp4Fun/
% 2. Lancia questo script
% 3. Ottieni ranking per i 5 RSOs: LEO / MEO / GEO
%
% Criteri (giustificati in README):
% - Mask 30 deg
% - Notte locale: Sole < -12 deg
% - Satellite illuminato
% - Ranking: max elevation, durata, fase

clear; clc;
addpath('../src');

% Osservatorio: Collepardo (FR)
lat_obs = 41.7605; lon_obs = 13.3678; alt_obs = 0.59;

% Finestra: 2026-05-11 12:00 UTC -> +24h, step 30s
t_start = datetime(2026,5,11,12,0,0,'TimeZone','UTC');
t_vec = t_start : seconds(30) : t_start + hours(24);

% 5 target del progetto
targets = {'HULIANWANG DIGUI-100', 'IRIDIUM 172', ...
           'ARKTIKA-M 1', 'METEOSAT-10', 'LUCH 5B'};
norad = [66416, 43927, 47719, 38552, 38977];

fprintf('Target | Orbita | Max El | Durata | Fase\n');
fprintf('-----------------------------------------\n');

for i = 1:length(targets)
    % Carica TLE da data/ - path relativo, mai assoluto
    tle = load_TLE(norad(i));
    
    % Classifica orbita da semiasse maggiore medio
    orbita = classifica_orbita(tle.satrec);
    
    % Propaga + check visibilita' con mask 30 deg
    [max_el, durata, fase] = check_visibility(tle, t_vec, lat_obs, lon_obs, alt_obs);
    
    fprintf('%s | %s | %.1f deg | %.1f min | %.1f deg\n', ...
        targets{i}, orbita, max_el, durata, fase);
end

% Risultato atteso (vedi README):
% HULIANWANG: LEO, miglior compromesso El/durata
% ARKTIKA-M 1: classificato MEO ma e' Molniya e=0.727
