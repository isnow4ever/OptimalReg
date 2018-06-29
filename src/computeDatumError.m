function datum_error = computeDatumError(datum_model,datum_data,normal)
%COMPUTEDATUMERROR 此处显示有关此函数的摘要
%   此处显示详细说明
    datum_error = 0.0;
    idx = knnsearch(datum_data,datum_model);
    y = datum_data(idx,:);
    x = datum_model;
    w = normal;
    v = y - x;
    e = v.*w;
    datum_error = datum_error + e*e;
end

