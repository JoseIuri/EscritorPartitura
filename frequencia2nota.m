function nota = frequencia2nota(freqs)
sf = size(freqs);
nota = cell(sf);
for r = 1:sf(1)
        if (freqs(r) == 0)
            str = 'P';
        else            
            n = round(12*log2(freqs(r)/27.5));
            switch mod(n,12)
                case 0
                    str = 'A';
                case 1
                    str = 'A#';
                case 2 
                    str = 'B';
                case 3 
                    str = 'C';
                case 4 
                    str = 'C#';
                case 5 
                    str = 'D';
                case 6 
                    str = 'D#';
                case 7 
                    str = 'E';
                case 8 
                    str = 'F';
                case 9 
                    str = 'F#';
                case 10 
                    str = 'G';
                case 11 
                    str = 'G#';
            end
            
            %%
            aux = floor((n+9)/12)
            
            if (aux <= 3)
                aux = 3;
            elseif (aux >= 5)
                aux = 5
            end
            
            str = [str,num2str(aux)];
            
            %%
            %str = [str,num2str(floor((n+9)/12))];
        end
        nota(r) = cellstr(str);
end