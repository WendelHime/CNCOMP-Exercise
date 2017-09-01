// Este programa foi construido com o intuito de auxiliar o usuario
// na tarefa de ajustes a equipamentos como sonar e hidrofones.
 
// Com base no Material escrito pelo Prof. Dr. Joseph Harari
// e disponibilizado impresso durante aulas da disciplina IOF 1202
// - Oceanografia Física Descritiva, ministrada no Instituto Oceanográfico
// da Universidade de São Paulo no ano de 2007.
// a velociade do som no mar pode ser expressa com a seguinte formula:
// c = 1449 + 4,6 t − 0,055 t2 + 1,4 (S − 35) + 0,017 D
// onde Velocidade do som c (em m/s^-1) depende de salinidade S, temperatura t (em °C),
// e profundidade D (em m)
// Para a superfície, t = 0°C e S = 35, c aumenta 4 m/s para Δt = +1°C,
// aumenta 1,4 m/s para ΔS = +1 e aumenta 1,7 m/s para ΔD = +100 m (efeito da pressão).
s = input("Insira a salinidade da água: ");

intervalo_profundidade = [0:500:4500]; 
intervalos_temperatura = [];
for i = 1:length(intervalo_profundidade)
    intervalos_temperatura(1, i) = input(strcat(["Insira o valor da temperatura da profundidade em  ", string(intervalo_profundidade(i)), "m"])); 
end
 
polinomioTemperatura = poly([1449 4.6 -0.055], "t", "coeff") 
c = []

for i = 1:length(intervalo_profundidade)
    c(1, i) = horner(polinomioTemperatura, intervalos_temperatura(1, i)) + 1.4 * (s - 35) + 0.017 * intervalo_profundidade(1, i); 
end
 
xtitle("Velocidade do som pela profundidade");
xlabel("Profundidade em m");
ylabel("Velocidade do som em m/(s^-1)");
plot(intervalo_profundidade, c, "*") ;
