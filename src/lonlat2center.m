function [lonc, latc] = lonlat2center(lon, lat);

    iub = size(lat,1)-1;
    jub = size(lat,2)-1;

    for i=1:iub;
    for j=1:jub;
        
        XSW = lon(i, j);
        YSW = lat(i, j);
        XSE = lon(i, j + 1);
        YSE = lat(i, j + 1);
        XNE = lon(i + 1, j + 1);
        YNE = lat(i + 1, j + 1);
        XNW = lon(i + 1, j);
        YNW = lat(i + 1, j);
        
        lonc(i,j) = (XSW + XSE + XNE + XNW) / 4.;
        latc(i,j) = (YSW + YSE + YNE + YNW) / 4.;

    end;
    end;
  
    
end
