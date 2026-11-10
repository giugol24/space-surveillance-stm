% Esempio riproducibile: HULIANWANG DIGUI-100
% TLE e osservazioni caricate da data/ con path relativo
% Risultato atteso: 0.20 deg -> 0.069 deg, 24h diff 7.3 km
% Per MEO/GEO stesso codice -> 0.01 deg ma 28-33k km diff
% = short-arc overfitting, discussione in README Part 2

load('../data/example_hulianwang.mat'); % TLE + RA/Dec simulati
[best, cost, hist] = pso_refine_TLE(tle0, t, ra, dec, 'LEO');
plot(hist); xlabel('Iterazione'); ylabel('Best Function Value');
