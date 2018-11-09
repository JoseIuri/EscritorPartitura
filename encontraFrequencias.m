function frequencias = encontraFrequencias(musica,fs,mudanca)

    % Normalizar a musica
    musica = musica/max(abs(musica));
    
    % Inicializa o vetor
    frequencias = zeros(length(mudanca)-1,1);

    % Loop para separar as notas
    for(qSegmento = 1:length(mudanca)-1)
        
        segmento = musica(mudanca(qSegmento):mudanca(qSegmento+1));
        
        espectro = fft(segmento,8*length(segmento));
        espectro = abs(espectro(1:ceil(length(espectro)/2)));

        numNota = 1;
        
        % Pico da onda
        if(max(espectro) > 200)
            
            espectro = espectro .^ 2;
            espectro = espectro/max(espectro);
            
            % Loop para encontrar o pico
            for(i = 2:length(espectro)-1)
                
                if(espectro(i) > .1 & espectro(i) > espectro(i-1) & espectro(i) > espectro(i+1))
                    
                    % Não guarda dois picos sem diferença significativa
                    if(abs(i*fs/(length(espectro)*2) - frequencias(qSegmento,numNota)) > 10)
                        
                        nfreq = i*fs/(length(espectro)*2);
                        
                        % Remover os harmonicos
                        if(numNota >= 2)
                            possivelHarmonico = 0;
                            
                            for(j = 2:numNota)
                                
                                % Uma nota e um possivel harmonico se sua frequencia e  3% do harmonico perfeito
                                if(mod(nfreq,frequencias(qSegmento,j)) < .03*nfreq | ...
                                    frequencias(qSegmento,j) - mod(nfreq,frequencias(qSegmento,j))  < .03*nfreq)
                       
                                if(espectro(i) < .3*frequencias(qSegmento,j)*2*length(espectro)/fs)
                                        possivelHarmonico = 1;
                                    end
                                end
                            end
                            if(~possivelHarmonico)
                                numNota = numNota + 1;
                                frequencias(qSegmento,numNota) = nfreq;
                            end
                        else
                            numNota = numNota + 1;
                            frequencias(qSegmento,numNota) = nfreq;
                        end
                    end
                end
            end
        end
    end
    
    [linhas,colunas] = size(frequencias);
    if(colunas >= 2)
        frequencias = frequencias(:,2:colunas);
    end
end