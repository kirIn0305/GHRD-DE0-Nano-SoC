parameter CYCLE = 100;
parameter HALF_CYCLE = 50;
parameter DELAY = 10;
reg CLK;

always #(HALF_CYCLE)
    CLK <= ~CLK;
