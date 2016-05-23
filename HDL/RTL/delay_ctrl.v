/*================================================================================
| delay led 
|---------------------------------------------------------------------------------
| Block name  : delay_ctrl
| Version     : 0.0.0
| Description :
|     - delay variable that the blinker module
|
|---------------------------------------------------------------------------------
| Created by  : kirIn
\===============================================================================*/

`default_nettype none

module delay_ctrl(clk, faster, slower, delay, reset, write, writedata);
    //============================ IO pins ============================
    input wire clk;
    input wire faster;
    input wire slower;
    output wire [3:0] delay;
    input wire reset;
    input wire write;
    input wire [7:0] writedata;

    //============================ Wire and Reg ============================
    reg [3:0]  delay_intern = 4'b1000;

    //================================================================================
    // Logic
    //================================================================================
    always @(posedge clk) begin
        if(reset)
            delay_intern <= 4'b1000;
        else if (write)
            delay_intern <= writedata[3:0];
        else if (faster && delay_intern != 4'b0001)
            delay_intern <= delay_intern - 1'b1;
        else if (slower && delay_intern != 4'b1111)
            delay_intern <= delay_intern + 1'b1;
    end

    assign delay = delay_intern;

endmodule

`default_nettype wire
