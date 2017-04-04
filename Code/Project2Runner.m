clear all;
close all;
clc;



% 方式1
% 读入所有图片
im = cell(1, 18) ;
img = cell(1, 18) ;
for i = 1:18
    % 读入图片
    inputimgname = strcat('/home/austin/Documents/计算机视觉与模式识别/Project2/Input/', num2str(i), '.JPG') ;
    im{i} = imread(inputimgname) ;
    
%     % 映射球面坐标
%     im{i} = spherical(im{i}) ;
%     if mod(i, 3) ~= 0
%         im{i} = spherical(im{i}) ;
%     end
    
    % 映射柱面坐标
    im{i} = cylinder(im{i}) ;

    % make single
    im{i} = im2single(im{i}) ;
    
    % make grayscale
    if size(im{i}, 3) > 1
        img{i} = rgb2gray(im{i}) ;
    else
        img{i} = im{i} ;
    end
end

% 先手动将图片排序，再逐个两两拼接
mosaic = im{1} ;
for i = 2:length(im)
    disp(i-1)
    
    mosaic = sift_mosaic(mosaic, im{i}, i-1) ;
end

% 裁剪掉不规则的边缘
mosaic = cut(mosaic) ;

imwrite(mosaic, '/home/austin/Documents/计算机视觉与模式识别/Project2/Output/test10.jpg');

% % 方式2
% % 读入所有图片
% im = cell(1, 18) ;
% img = cell(1, 18) ;
% for i = 1:18
%     % 读入图片
%     inputimgname = strcat('/home/austin/Documents/计算机视觉与模式识别/Project2/Input/', num2str(i), '.JPG') ;
%     im{i} = imread(inputimgname) ;
%     
%     % 映射球面坐标
%     im{i} = spherical(im{i}) ;
%     
%     % make single
%     im{i} = im2single(im{i}) ;
%     
%     % make grayscale
%     if size(im{i}, 3) > 1
%         img{i} = rgb2gray(im{i}) ;
%     else
%         img{i} = im{i} ;
%     end
% end
% 
% % 对图片做两两SIFT/SANSAC匹配，找出匹配度最高的两张图片做mosaic
% % 再继续将mosaic得出的图片与其它未做mosaic的图片匹配
% % 直至得出最终的全景图
% while length(im) > 1
%     disp(length(im))
%     
%     % 根据SIFT找到最匹配的图片
%     f = cell(1, length(im)) ;
%     d = cell(1, length(im)) ;
%     for i = 1:length(im)
%         [f{i}, d{i}] = vl_sift(img{i}) ;
%     end
%     
%     matches = cell(1, length(im)-1) ;
%     scores = cell(1, length(im)-1) ;
%     numMatches = zeros(length(im)-1, 2) ;
%     for  i = 1:length(im)-1
%         [matches{i}, scores{i}] = vl_ubcmatch(d{1}, d{i+1}) ;
%         
%         numMatches(i, 1) = i+1 ;
%         numMatches(i, 2) = size(matches{i}, 2) ;
%     end
%     
%     % 选出匹配度最高的一张图片
%     numMatches = sortrows(numMatches, -2) ;
%     index = numMatches(1, 1) ;
%     
%     mosaic = sift_mosaic(im{1}, im{index}) ;
%     
%     % 更新图片组
%     % 将新拼接好的图像加入到待处理的图片组
%     % 并从图片组删除做了拼接的两张图像
%     im_tmp = cell(1, length(im)-1) ;
%     img_tmp = cell(1, length(img)-1) ; 
%     im_tmp{1} = mosaic ;
% 
%     % make single
%     im_tmp{1} = im2single(im_tmp{1}) ;
%     
%     % make grayscale
%     if size(im_tmp{1}, 3) > 1
%         img_tmp{1} = rgb2gray(im_tmp{1}) ;
%     else
%         img_tmp{1} = im_tmp{1} ;
%     end
%     count = 2 ;
%     for i = 2:length(im)
%         if i == index
%             continue
%         end
%         im_tmp{count} = im{i} ;
%         img_tmp{count} = img{i} ;
%         count = count +1 ;
%     end
%     im = im_tmp ;
%     img = img_tmp ;
% end



% % 方式3
% % 读入所有图片
% im = cell(1, 18) ;
% for i = 1:18
%     % 读入图片
%     inputimgname = strcat('/home/austin/Documents/计算机视觉与模式识别/Project2/Input/', num2str(i), '.JPG') ;
%     im{i} = imread(inputimgname) ;
% end
% 
% % 相邻两个图像做拼接
% while length(im) > 1
%     im_tmp = cell(1, uint8(length(im)/2)) ;
%     for i = 1:2:length(im)
%         if i == length(im)
%             im_tmp{(i+1)/2} = sift_mosaic(im{i-1}, im{i}) ;
%         else
%             im_tmp{(i+1)/2} = sift_mosaic(im{i}, im{i+1}) ;
%         end
%     end
%     im = im_tmp ;
% end