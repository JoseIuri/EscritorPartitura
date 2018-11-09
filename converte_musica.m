function [musica,tempo] = converte_musica(arquivo)

    [musica,fs] = audioread(arquivo);
    pontos = mudanca(musica,fs); 
    frequencias = encontraFrequencias(musica,fs,pontos);
    notas = frequencia2nota(frequencias);
    [musica,tempo] = duracao(pontos,notas,fs);
    
    partitura=desenha(musica);

end