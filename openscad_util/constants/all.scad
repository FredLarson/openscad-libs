epsilon = 0.05; // overlap adjacent volumes by this amount
inch = 25.4; // 25.4 mm per inch

x_axis=0;
y_axis=1;
z_axis=2;

function fn(r) = $fn > 0 ? $fn : max(5, ceil(min(360/$fa, r*2*PI/$fs)));
