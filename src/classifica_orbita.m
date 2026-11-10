function orbita = classifica_orbita(satrec)
    % Classificazione da semiasse maggiore medio
    % satrec.a in raggi terrestri (SGP4)
    % Usata per decidere bounds PSO e ranking visibilità
    alt_km = (satrec.a - 1) * 6378.1363;

    if alt_km < 2000
        orbita = 'LEO';
    elseif alt_km < 35786 - 1000
        orbita = 'MEO';
    else
        orbita = 'GEO';
    end
end
