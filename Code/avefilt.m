function x1 = avefilt(x, l)
    n = 9 ;      % 滤波窗口大小
    a(1:n,1:n)=1;   %a即n×n模板,元素全是1
    p=size(x);   %输入图像是p×q的,且p>n,q>n
    x1=x ;
    
    for i=1:p(1)-n+1
        for j= l-5 : l+5
            for k = 1 : 3
                c=x(i:i+(n-1),j:j+(n-1), k).*a;  %取出x1中从(i,j)开始的n行n列元素与模板相乘
                s=sum(sum(c));                 %求c矩阵(即模板)中各元素之和
                x1(i+(n-1)/2,j+(n-1)/2, k)=s/(n*n); %将模板各元素的均值赋给模板中心位置的元素
            end
        end
    end
end