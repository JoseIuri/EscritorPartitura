function partitura=desenha(musica)

notas = (musica(:,1));
tempo = zeros (length(musica(:,1)),1);
simbolos = musica(:,length(musica(1,:)));

for j = 1:length(musica(:,1))
    dur = char(simbolos(j,1));
    switch dur
        case 'colcheia'
            tempo(j,1) = 0.5;
        case 'semiminima'
            tempo(j,1) = 1;
        case 'semiminima ponto'
            tempo(j,1) = 1.5;
        case 'minima'
            tempo(j,1) = 2;
        case 'minima ponto'
            tempo(j,1) = 3;
        case 'semibreve'
            tempo(j,1) = 4;
        otherwise
            tempo(j,1) = 0;
    end
end

comecou = 1;

g = 1;

partitura = imread('Notas\clave\inicio.png');
inicio = partitura;

while (g ~= 0)
    
    linha = imread('Notas\clave\sol.png');
    
    compasso = 0;
    
    i = 1;
    
    numero = 0;
    
    while (i ~= 0)
        
        if (g <= length(tempo(:,1) ))
            
            if (numero <= 6)
                compasso = compasso + tempo(g,1);
                filename = 'Notas\';
                if (compasso < 4)
                    filename = [filename,char(musica(g,length(musica(1,:)))),'\',char(notas(g)),'.png'];
                    [image1,map1] = imread(filename);
                    linha = [linha, image1];
                    g = g + 1;
                    
                elseif (compasso == 4)
                    filename = [filename,char(musica(g,length(musica(1,:)))),'\',char(notas(g)),'.png'];
                    [image1,map1] = imread(filename);
                    [image2,map2] = imread('Notas\clave\barra.png');
                    linha = [linha, image1];
                    linha = [linha, image2];
                    compasso = 0;
                    numero = numero + 1;
                    g = g + 1;
                else
                    
                    compasso = compasso - tempo((g),1);
                    pausa = 4 - compasso;
                    
                    switch (pausa)
                        
                        case 0.5
                            [iPausa,map3] = imread('Notas\colcheia\P.png');
                            linha = [linha, iPausa];
                        case 1
                            [iPausa,map3] = imread('Notas\semiminima\P.png');
                            linha = [linha, iPausa];
                        case 1.5
                            [iPausa,map3] = imread('Notas\semiminima ponto\P.png');
                            linha = [linha, iPausa];
                        case 2
                            [iPausa,map3] = imread('Notas\minima\P.png');
                            linha = [linha, iPausa];
                        case 2.5
                            [iPausa,map3] = imread('Notas\minima\P.png');
                            [iPausa2,map4] = imread('Notas\colcheia\P.png');
                            iPausa = [iPausa, iPausa2];
                            linha = [linha, iPausa];
                        case 3
                            [iPausa,map3] = imread('Notas\minima ponto\P.png');
                            linha = [linha, iPausa]
                        case 3.5
                            [iPausa,map3] = imread('Notas\minima ponto\P.png');
                            [iPausa2,map4] = imread('Notas\colcheia\P.png');
                            iPausa = [iPausa, iPausa2];
                            linha = [linha, iPausa];
                    end
                    
                    [image2,map2] = imread('Notas\clave\barra.png');
                    linha = [linha, image2];
                    compasso = 0;
                    numero = numero + 1;
                end
            end
        end
        if (numero == 6 | (g >= length(tempo(:,1) )))
            i = 0;
        end
    end
    
    diferenca = 1800-length(linha(1,:,1));
    [preencher,map2] = imread('Notas\clave\preencher.png');
    if (diferenca > 0)
        for f=1:diferenca
            linha = [linha,preencher];
        end
    end
    
    [image2,map2] = imread('Notas\clave\fim.png');
    linha = [linha,image2];
    
    if (comecou == 1)
        partitura = zeros(length(linha(:,1,1)),length(linha(1,:,1)),3);
        partitura = partitura + 255;
        comecou = 0;
    end
    
    partitura = [partitura; linha];
    
    numero = 0;
    
    if ((g+1) >= length(tempo(:,1)))
        g = 0;
    end
end

image(partitura)
axis off
axis image

end
