function x1 = midfilt(x, l)
    n = 9 ;      % 滤波窗口大小
    a(1:n,1:n)=1;   %a即n×n模板,元素全是1
    p=size(x);   %输入图像是p×q的,且p>n,q>n
    x1=x ;
    
    for i=1:p(1)-n+1
        for j= l-5 : l+5
            for k = 1 : 3
                c=x(i:i+(n-1),j:j+(n-1), k);  %取出x1中从(i,j)开始的n行n列元素,即模板(n×n的)
                e=c(1, :);      %是c矩阵的第一行
                for u=2:n
                    e=[e,c(u, :)];     %将c矩阵变为一个行矩阵    
                end
                mm=median(e);      %mm是中值
                x1(i+(n-1)/2,j+(n-1)/2, k)=mm;   %将模板各元素的中值赋给模板中心位置的元素
            end
        end
    end
end