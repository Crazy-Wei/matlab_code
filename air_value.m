function [A1, A2] = air_value(r, g, b, dark_image)

%------------------------------
% tic;
lmt1 = quantile(dark_image(:), [0.999]);      
[r1,c1] = find(dark_image >= lmt1);
[enum1, ~] = size(r1);
rch_air_sum =0;
gch_air_sum =0;
bch_air_sum =0;
for i=(1:enum1)
    rch_air_sum = r(r1(i), c1(i)) + rch_air_sum;
    gch_air_sum = g(r1(i), c1(i)) + gch_air_sum;
    bch_air_sum = b(r1(i), c1(i)) + bch_air_sum;
end

rch_air = rch_air_sum / enum1;
gch_air = gch_air_sum / enum1;
bch_air = bch_air_sum / enum1;
A1 = mean([rch_air, gch_air, bch_air]);
% toc;
%---------------------------------

%---------------------------------
% tic;
lmt2 = quantile(dark_image(:), [0.999]);      
[r2, c2] = find(dark_image >= lmt2);
[enum2, ~]=size(r2);
air_sum =0;
for i=(1:enum2)
    air_sum = dark_image(r2(i), c2(i)) + air_sum;
end

A2 = air_sum ./ enum2;
% toc;
%---------------------
% tic;
[row, col] = size(dark_image);
img_dark_sort = sort(dark_image(:));
num = round(row * col * 0.001);
shred = img_dark_sort(row * col -num + 1, 1);
[pos_r, pos_c, ~] = find(dark_image >= shred, num);

A3 = zeros(3, 1);
maxgray = zeros(3, num);
img = cat(3, r, g, b);
for s=1:3%三个通道分别取最大值 
    for i=1:num%从原图取出以上位置的值
        maxgray(s, i) = img(pos_r(i, 1), pos_c(i, 1), s);
    end
    maxgray = sort(maxgray, 2);
    A3(s, 1) = maxgray(s, num);
end
% toc;
%------------------------

end