fft_size = 256;

output_int = zeros(fft_size*2,1);
for idx = 0:fft_size-1
    
    output_now = exp(-1i*2*pi*idx/fft_size);
    output_int(2*idx + 1) = real(output_now);
    output_int(2*idx + 2) = imag(output_now);

end

output_int = round(output_int*2^14);

fid = fopen('complex_exp.h','w');
fprintf(fid,'int exp_values[] = {\n');
fprintf(fid,'%d,\n',output_int);
fprintf(fid,'};\n');
fclose(fid);

