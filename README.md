# coronavirus_asymptomatic
Linking asymptomatic case characteristics with the epidemic potential of coronavirus-like outbreaks
Joshua S. Weitz
Biological Sciences, Physics
Georgia Tech
2020
MIT License

MATLAB code to generate heatmaps quantifying the relevance of asymptomatic transmission given variation 
in relative transmission and probability that a given, newly infected individual is asymptomatic. 
The code is based on a SEIR-variant with asymptomatic and symptomatic classes.

\begin{eqnarray}
\dot{S}&=&-\beta_a S I_a -\beta_s S I_s \\
\dot{E}&=&\beta_a S I_a +\beta_s S I_s -\gamma_e E\\
\dot{I}_a&=&p\gamma_e E-\gamma_a I_a\\
\dot{I}_s&=&(1-p)\gamma_e E-\gamma_s I_s\\
\dot{R}&=&\gamma_a I_a + (1-f)\gamma_s I_s \\
\dot{D}&=&f\gamma_s I_s.
\end{eqnarray}

