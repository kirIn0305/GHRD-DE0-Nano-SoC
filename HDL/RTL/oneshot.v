/*================================================================================
| oneshot
|---------------------------------------------------------------------------------
| Block name  : oneshot
| Version     : 0.0.0
| Description :
|     - 
|
|---------------------------------------------------------------------------------
| Created by kirIn : 
\===============================================================================*/

`default_nettype none

module oneshot(clk, edge_sig, level_sig);
//============================ IO pins ============================
    input wire clk;
    input wire [3:0] edge_sig;
    output wire [3:0] level_sig;
//============================ Wire and Reg ============================
    reg [3:0]  cur_value;
    reg [3:0]  last_value;

//================================================================================
// Logic
//================================================================================
    always @(posedge clk) begin
        cur_value <= edge_sig;
        last_value <= cur_value;
    end

    assign level_sig = ~cur_value & last_value;

endmodule

`default_nettype wire
