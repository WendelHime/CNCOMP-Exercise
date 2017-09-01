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



// implementação de regreção polinomial
// Prof. Filipe Taveiros UFRN - disponivel em https://www.passeidireto.com/arquivo/6740095/aula-4---ajuste-de-curvas---atualizado
function [x] = retroativa(A,b)
    [l,c] = size(A);
    for i=c:-1:1
        soma =0;
        for j=i+1:c
            soma =soma +x(j)*A(i,j);
        end
        x(i) = (b(i) - soma)/A(i,i);
    end
endfunction

function [x] = sislingauss(A,b)
    [l,c] = size(A);
    Aa = [A b]; //matriz aumentada 
    for i=1:l-1//Início do escalonamento
        pivo=Aa(i,i);
        for j=i+1:c
            m = -Aa(j,i)/pivo;
            Aa(j,:) =Aa(j,:) +m*Aa(i,:);
        end
    end
    A =Aa(:,1:c);
    b =Aa(:,c+1);
    x =retroativa(A,b); //Solução
endfunction
            
function a =Lpolinomial(x,y,k)
    for j=0:k //Laço que varre as colunas
        for i=0:k //Laço que varre as linhas
            A(i+1,j+1)=sum(x.^(j+i));
        end
        b(j+1,1)=sum(y.*x.^(j));
    end
    a=sislingauss(A,b);
endfunction

// polinomio de grau 4
as = Lpolinomial(intervalo_profundidade,c,4)
y_polinomio =  polinomio(5)*intervalo_profundidade.^4 + polinomio(4)*intervalo_profundidade.^3 + polinomio(3)*intervalo_profundidade.^2 + polinomio(2)*intervalo_profundidade + polinomio(1);
// suavizar curva
y_smooth=smooth([intervalo_profundidade;y_polinomio],0.1);
plot2d(y_smooth(1,:)',y_smooth(2,:)',[1],"000");
