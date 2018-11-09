function when=mudanca(musica,FS)

P=5200/44100*FS;        % tamanho do filtro
N=length(musica);       % tamanho da musica
thresh=0.1;             % limiar de detecçao
threshlow=-0.3;
reso=round(P*1.5);      % sensibilidade da isolacao de pico (1.5 padrão)
                        

% ---------------% normaliza a musica ---------------------------%
musica=musica/max(abs(musica));


%---------------------% build filter %------------------------------------%
detecta=gaussfilt(P);


%---% convolui o filtro com a musica para encontrar as bordas %---%
borda=fconv(abs(musica),detecta);
tbordas=borda(P/2:N+P/2-1);         
tbordas=tbordas/max(abs(tbordas));    % normaliza


%-------------------------% Encontra os picos %------------------%
times=zeros(1,N);       
for c=2:N               % valores maximos
    if tbordas(c)>thresh
        if tbordas(c)>tbordas(c-1)
            times(c)=1;
            times(c-1)=0;
        end
    end
end

for c=2:N               % minimos
    if tbordas(c)<threshlow
        if tbordas(c)<tbordas(c-1)
            times(c)=1;
            times(c-1)=0;
        end
    end
end

for d=2:N                
    if times(d)==1
        if (N-d <= reso)
            times(d+1:N)=0;
        else
            times(d+1:d+reso)=0;
            d=d+reso;    
        end
    end
end

count=1;
for e=1:N       % encontra os picos     
    if times(e)==1
        temp(count)=e;
        count=count+1;
    end
end
when=temp';

endsum=sum(times(N-reso:N));    
if (endsum == 0)
    when(length(when)+1)=N;
end
    
return



% ------ convolucao ------- %
function out=fconv(f,h)
P=length(f)+length(h)-1;
fnew=zeros(1,P);
hnew=zeros(1,P);
fnew(1:length(f))=f;
hnew(1:length(h))=h;
out=ifft(fft(fnew).*fft(hnew));
return



% ------------- % Filtro de deteccao de borda % ----%
% written by Nick Berndsen
% last updated 12-10-06


function filter=gaussfilt(N)

% calculate alpha so the filter fills all N points
alpha=N;
first=-(1-N/2)*exp(-(1-N/2)^2/alpha);
count=0;
while first<.1*(-(1530/4000*N-N/2)*exp(-(1530/4000*N-N/2)^2/alpha))
    count=count+1;
    alpha=N*500*count;
    first=-(1-N/2)*exp(-(1-N/2)^2/alpha);
end

for n=1:N
    filter(n)=-(n-N/2)*exp(-(n-N/2)^2/alpha);   % d/dt of a gaussian
end
filter=filter/sum(abs(filter));     % normalization

return