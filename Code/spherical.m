function im = spherical(src)
    %DstImage = SrcImage;
    [h, w, r, N] = size(src);
    %disp(width);

    %Get Focal Length
    f=sqrt(h^2 + w^2);

    %Project to a spherical
    alpha = 45;
    beta = 2*atan(h*tan(alpha*pi/360)/w)*180/pi;
    alpha = alpha * pi / 180;
    beta = beta * pi / 180;

    half_w = w / 2;
    half_h = h / 2;

    for y = 1:w
        for x = 1:h
            kx = sqrt(f^2 + (half_w-y)^2);
            ky = sqrt(f^2 + (half_h-x)^2);

            dx = uint16(f*sin(alpha/2)+f*sin(atan((x-half_w)/kx)));
            dy = uint16(f*sin(beta/2)+f*sin(atan((y-half_h)/ky))); 

            if dy == 0
                dy = 1;
            end
            if dx == 0
                dx = 1;
            end

            for n = 1:N
                im(dx, dy, :, n) = src(x, y, :, n);
            end

        end
    end
end