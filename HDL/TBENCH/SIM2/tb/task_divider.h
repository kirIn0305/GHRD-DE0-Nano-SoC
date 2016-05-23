task set_divider;
input [7:0] in1, in2;
begin
    i1 = in1; i2 = in2;
    @(posedge CLK) #DELAY;
        i1 = 8'bz; i2 = 8'bz;
end
endtask
