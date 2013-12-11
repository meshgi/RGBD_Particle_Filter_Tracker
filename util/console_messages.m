function console_messages( comm , str )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    global s;

    switch (comm)
        case 'clear'
            clc();
            s = '';
        case 'add'
            s = [s str];
        case 'newline'
            s = sprintf('%s\n%s',s,str);
    end
    disp (s);

end

