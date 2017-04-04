function output_im = cut(input_im)
    % 左边界
    x_left = 0 ;
    
    % 右边界
    x_right = size(input_im, 2)
    flag_out = false ;
    for i = size(input_im, 2): -1 : 1
        continue_num1 = 0 ;
        for j = 1 : size(input_im, 1)
            continue_num2 = 0 ;
            for k = 1 : 3
                if input_im(j, i, k) ~= 0
                    break
                end
                
                continue_num2 = continue_num2 + 1 ;
            end
            
            if continue_num2 == 3
                continue_num1 = continue_num1 + 1 ;
                
                if continue_num1 == 5
                    break
                end
            else
                continue_num1 = 0 ;
            end
        end
        
        if continue_num1 ~= 5
            x_right = i ;
            break
        end
    end
    
    output_im = input_im ;
end