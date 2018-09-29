# I
function simpsonrep(f, a, b; m = 101)
    if m%2==0
        m=m+1
    end
    h=(b-a)/(m-1)
    v=zeros(m,1)
    for i=1:m
        v[i]=a+h*(i-1)
    end
    soma1=0;
    soma2=0;
    for i=2:2:m-1
        soma1=soma1+f(v[i])
        soma2=soma2+f(v[i+1])
    end
    soma2=soma2-f(v[m])
    return h*(f(v[1])+4*soma1+2*soma2+f(v[m]))/3 
end

function simpsoneps(f, a, b, ϵ; M = 1.0)
    h=((180*eps)/((b-a)*M))^(1/4)
    m= ceil(Int, (b-a)/h +1)
    return simpsonrep(f,a,b,m)
end

# II
function simpson(f, a, b)
    return (b-a)*(f(a)+4f((a+b)/2)+f(b))/6
end

function simpson_adaptivo(f, a, b, ϵ)
    I = simpson(f, a, b)
    return simpson_adaptivo_recursivo(f, a, b, ϵ, I)
end

function simpson_adaptivo_recursivo(f, a, b, ϵ, I)
    c=(a+b)/2
    esquerda=simpson(f,a,c)
    direita=simpson(f,c,b)
    if abs(I-esquerda-direita)<15*eps
        return esquerda+direita
    end
    return simpson_adaptivo_recursivo(f,a,c,eps,esquerda)+simpson_adaptivo_recursivo(f,c,b,eps,direita)
end
