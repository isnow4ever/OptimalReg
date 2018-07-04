function datum_error = computeDatumError(datum_model,datum_data,normal)
%COMPUTEDATUMERROR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    datum_error = 0.0;
    for i = 1 : datum_model.Count
        point = datum_model.Location(i,:);
        [idx,dist] = findNearestNeighbors(datum_data,point,1);   
%     idx = knnsearch(datum_data,datum_model);
        y = datum_data.Location(idx,:);
        x = datum_model.Location(i,:);
        w = normal;
        v = y - x;
        e = v*w';
        datum_error = datum_error + e*e;
    end
end

