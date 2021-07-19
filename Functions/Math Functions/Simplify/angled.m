function result = angled(f)
% Angle of cartesian coordinates in degrees

% Solve in radians
temp=angle(f);
% Convert to degrees
result=rad2deg(temp);
end

