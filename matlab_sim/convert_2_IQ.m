function data_out = convert_2_IQ(fileID)

    fid = fopen(fileID,'r');
    data_bytes = fscanf(fid,'%d\n')';
    fclose(fid);

    % complex(i/(255/2) - 1, q/(255/2) - 1)
    
    data_out = data_bytes(1:2:end)/2 - 1 + 1i*(data_bytes(2:2:end)/2 - 1);
end