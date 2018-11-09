function [musica,tempo] = duracao(pontos,notas,fs)
durs = zeros(1,length(pontos)-1);

for n = 1:length(durs)
    durs(n)=pontos(n+1)-pontos(n);
end

dist=zeros(1,ceil(max(durs)/1000)*1000);

for n = 1:length(durs)
    dist(durs(n))=dist(durs(n))+1;
end

N = 60;
histdist=histcounts(durs,0:ceil(length(dist)/N):length(dist));

[val,loc]=max(histdist);
loc = (loc-.5)*length(dist)/N;
quarter=avex2(dist(ceil(loc*7/8):min(length(dist),floor(loc*9/8))),ceil(loc*7/8));
num8=round(2*durs/quarter);
lengths = cell(length(durs),1);

for n = 1:length(durs)
    switch(num8(n))
        case 1
            lengths(n) = cellstr('colcheia');
        case 2
            lengths(n) = cellstr('semiminima');
        case 3
            lengths(n) = cellstr('semiminima ponto');
        case 4
            lengths(n) = cellstr('minima');
        case 6
            lengths(n) = cellstr('minima ponto');
        case 8
            lengths(n) = cellstr('semibreve');
        otherwise
            lengths(n) = cellstr('sem medida');
    end
end

tam=size(notas);
musica = cell(tam(1),tam(2)+1);

for r = 1:tam(1)
    for c = 1:tam(2)
        musica{r,c}=notas{r,c};
    end
    musica{r,end}=lengths{r};
end
tempo = 60*fs/quarter;
end

function x = avex2(f,comeco)
if (nargin < 2)
    comeco = 1;
end
x = sum(([1:length(f)]+comeco-1).*f)/sum(f);
end