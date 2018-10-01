function [instantstr] = instant2str(instant)

    if instant < 10;
        instantstr = ['_0000',num2str(instant)];
    elseif instant < 100;
        instantstr = ['_000',num2str(instant)];
    elseif instant < 1000; 
        instantstr = ['_00',num2str(instant)];
    elseif instant < 10000;
        instantstr = ['_0',num2str(instant)];
    else
        instantstr = ['_',num2str(instant)];
    end

end