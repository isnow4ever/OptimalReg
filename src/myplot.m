function myplot(inputstr, targetstr)
    %输入的两个点云分别为input target
    input = pcread(inputstr);
    target = pcread(targetstr);
    %针对点云每一个点生成 RGB 矩阵
    inputM = input.Location;
    targetM = target.Location;
    mdl = KDTreeSearcher(targetM);
    idx =  knnsearch(mdl,inputM,'K',1);
    dist = zeros(size(inputM,1),1);
    for i = 1:size(dist,1)
        dist(i) = pdist([inputM(i,:);targetM(idx(i),:)],'euclidean');
    end
    distu = dist ./ max(dist);
    hsv = zeros(size(inputM,1),3);
    for i = 1:size(hsv,1)
        hsv(i,1) = distu(i);
        hsv(i,3) = 1;
        hsv(i,2) = 1;
    end
    RGB = hsv2rgb(hsv);
    %绘图
    ma = figure;
    pcshow(inputM,RGB);
    map = zeros(64,3);
    for i = 1:64
        map(i,:) = [(max(distu)-min(distu))/64*i+min(distu),1,1];
    end
    map = hsv2rgb(map);
    colormap(map);
    colorbar('Ticks',[0,0.33,0.67,1],'TickLabels',{strcat(num2str(min(dist)),"mm"),...
        strcat(num2str((max(dist)-min(dist))/4+min(dist)),"mm"),...
        strcat(num2str((max(dist)-min(dist))/2+min(dist)),"mm"),...
        strcat(num2str((max(dist)-min(dist))/4*3+min(dist)),"mm")});
    saveas(ma,'ma','fig');
end