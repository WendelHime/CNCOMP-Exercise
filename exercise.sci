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
//    intervalos_temperatura(1, i) = -0.338+(s*fD)/(1.485*(10^-4)*s*intervalo_profundidade(i) + fD);  
s = input("Insira a salinidade da água: ");

intervalo_profundidade = [0:1:4500]; 
temperaturaSuperficie = input("Insira o valor da temperatura na superfície: ");
intervalos_temperatura = [];
for i = 1:length(intervalo_profundidade)
    fD = 1+(%e^(-0.017*intervalo_profundidade(i)+1.4));
    intervalos_temperatura(1, i) = -0.055+(temperaturaSuperficie*fD)/(1.449*(10^-4)*temperaturaSuperficie*intervalo_profundidade(i) + fD);
end

polinomioTemperatura = poly([1449 4.6 -0.055], "t", "coeff") 
c = []

for i = 1:length(intervalo_profundidade)
    c(1, i) = horner(polinomioTemperatura, intervalos_temperatura(1, i)) + 1.4 * (s - 35) + 0.017 * intervalo_profundidade(1, i); 
end
 
xtitle("Velocidade do som pela profundidade");
xlabel("Profundidade em m");
ylabel("Velocidade do som em m/(s^-1)");
plot2d(intervalo_profundidade, c) ;
