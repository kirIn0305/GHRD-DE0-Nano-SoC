`timescale 10ps/1ps

module tbench;

    `include "tb/clk_common.h"
    `include "tb/instance_0.h"

    initial begin
        $dumpfile("./test.vcd");
        $dumpvars(0,pll_0);

        CLK <= 0;
        /* @(posedge CLK); */
        #(10 * CYCLE)    $finish();
    end


endmodule
