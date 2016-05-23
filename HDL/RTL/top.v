/*================================================================================
| Blinking LEDs
|---------------------------------------------------------------------------------
| Block name  : top.v
| Version     : 0.0.0
| Description :
|     - top module
|
|---------------------------------------------------------------------------------
| Created by kirIn  
\===============================================================================*/

`default_nettype none

module top(CLOCK_50, KEY, LED);

    //====================== IO pins ======================
    input wire CLOCK_50;
    input wire [3:0] KEY;
    output wire [3:0] LED;

    //====================== Wire and Reg ======================
    wire [3:0] key_os;
    wire [3:0] delay;
    wire main_clk = CLOCK_50;

    //================================================================================
    // Logic
    //================================================================================
    oneshot os (
        .clk(main_clk),
        .edge_sig(KEY),
        .level_sig(key_os)
    );

    delay_ctrl dc (
        .clk(main_clk),
        .faster(key_os[1]),
        .slower(key_os[0]),
        .delay(delay),
        .reset(key_os[3])
    );

    blinker b (
        .clk(main_clk),
        .delay(delay),
        .led(LED),
        .reset(key_os[3]),
        .pause(key_os[2])
    );

endmodule

`default_nettype wire
