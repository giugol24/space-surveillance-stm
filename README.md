# Space Surveillance & STM Toolbox (MATLAB)

Ground-based optical tracking from Collepardo: SGP4 propagation, visibility planning, and TLE refinement with PSO.

**Features:**
- SGP4 propagation validated vs Orbitron
- Visibility planning with mask 30 deg, Sun illumination, night condition
- Ranking by max elevation, duration, phase angle
- Orbit classification LEO / MEO / GEO by mean semi-major axis
- Custom local-neighborhood PSO for TLE refinement
- Cost function: mean angular LOS error in RA/Dec
- Tested on 5 RSOs: LEO, MEO, GEO, Molniya

**Results:**
<img width="700" height="525" alt="Sky_Map" src="plots/sky_map_az_el.png" />
<img width="700" height="525" alt="PSO_Convergence" src="plots/pso_convergence.png" />

## Part 2: PSO TLE Refinement
- 6 parameters optimized: i, RAAN, e, omega, M, n
- Bounds +-0.1% for LEO, +-5% / +-10% for MEO/GEO
- Swarm 80, MaxIter 50-200, adaptive inertia 0.4-1.0
- HULIANWANG DIGUI-100 (LEO): 0.20 deg -> 0.069 deg, 24h diff 7.3 km
- METEOSAT-10: 31.7 deg -> 0.007 deg, 24h diff 28.3 km
- LUCH 5B (GEO): 30.7 deg -> 0.010 deg, 24h diff 33.7 km
- Short-arc overfitting: angles fit to ~0.01 deg but orbit moves by 28-33k km for MEO/GEO
- B* improves the fit only marginally for short arcs
