`timescale 10ps/1ps

module tbench;

    `include "tb/clk_common.h"
    `include "tb/instance_0.h"
    `include "tb/task_divider.h"

    initial begin
        $dumpfile("./test.vcd");
        $dumpvars(0,div_u);

        CLK <= 0;
        @(posedge CLK) #DELAY;
            set_divider(8'h10, 8'h02);
        @(posedge CLK) #DELAY;
            set_divider(8'h0, 8'h02);
        @(posedge CLK) #DELAY;
            set_divider(8'h0, 8'h0);
        @(posedge CLK) #DELAY;
            set_divider(8'h7, 8'h3);
        @(posedge CLK) #DELAY;
            set_divider(8'h3, 8'h8);
        @(posedge CLK) #DELAY;
            set_divider(8'hff, 8'h88);
        @(posedge CLK) #DELAY;
            set_divider(8'd50, 8'd25);
        @(posedge CLK) #DELAY;
            set_divider(8'd128, 8'd4);
        /* @(posedge CLK); */
        #(100 * CYCLE)    $finish();
    end


endmodule
