function [ibottom itop jleft jright] = find_box(lonc, latc, xlims, ylims)

% xlims = [-9.5 -8.5];
% ylims = [38 39];
    
    [iub jub] = size(lonc);

    for i=1:iub;
        if latc(i,1) >= ylims(1);
            ibottom = i;
            break
        end
    end

    for i=1:iub;
        if latc(i,1) >= ylims(2);
            itop = i;
            break
        end
    end

    for j=1:jub;
        if lonc(1,j) >= xlims(1);
            jleft = j;
            break
        end   
    end

    for j=1:jub;
        if lonc(1,j) >= xlims(2);
            jright = j;
            break
        end
    end
