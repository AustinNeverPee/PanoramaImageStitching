function outpic1 = cylinder(pic1)
    [M,N,L] = size(pic1) ;
    th = 30 ;
    W = N ;
    h=th/2*pi/180 ;
    u=tan(h) ;
    f=W/2/u ;
%     f=600 ;
    
    half_M = M/2 ;
    half_N = N/2 ;

    outpic1 = uint8(zeros(M, uint8(2*f*atan(half_N/f)), L)) ;

    for col = 1:N
        for row = 1:M
            u = f*(col-half_N)/sqrt((col-half_N)*(col-half_N)+f*f) ;
            v = f*(row-half_M)/sqrt((col-half_N)*(col-half_N)+f*f) ;
            w = f*f/sqrt((col-half_N)*(col-half_N)+f*f) ;

            xx = f*atan(u/w)+f*atan(half_N/f) ;
            yy = v+half_M ;
            int_x = floor(xx)+double(xx<1) ;
            int_y = floor(yy)+double(yy<1) ;
            outpic1(int_y, int_x, :)= pic1(row, col, :) ;
        end
    end
end

