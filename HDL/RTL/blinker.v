/*================================================================================
| Blinking lED controller
|---------------------------------------------------------------------------------
| Block name  : blinker.v
| Version     : 0.0.0
| Description :
|     - controll LEDs
|
|---------------------------------------------------------------------------------
| Created by kirIn : 
\===============================================================================*/
`default_nettype none

module blinker(clk, delay, led, reset, pause);
    //====================== IO pins ======================
    input wire clk;
    input wire [3:0] delay;
    output reg [3:0]  led;
    input wire reset;
    input wire pause;

    //====================== Wire and Reg ======================
    reg [23:0]  count = 24'b0;
    reg [2:0] pos = 3'b0;
    reg running = 1'b1;

    //================================================================================
    // function
    //================================================================================

    always @(posedge clk) begin
        if(reset) begin
            count <= 24'b0;
            pos <= 3'b000;
            running <= 1'b1;
        end else if(pause) begin
            running <= !running;
        end else if(running) begin
            if (count == 24'b0) begin
                count <= {delay, 20'b0};
                if (pos == 3'b101)
                    pos <= 3'b000;
                else
                    pos <= pos + 1'b1;
            end else begin
                count <= count - 1'b1;
            end
        end
    end

    always @(pos) begin
        case (pos)
            3'b000 : led <= 4'b0001;
            3'b001 : led <= 4'b0010;
            3'b010 : led <= 4'b0100;
            3'b011 : led <= 4'b1000;
            3'b100 : led <= 4'b0100;
            3'b101 : led <= 4'b0010;
            default : led <= 4'b0000;
        endcase
    end
    
endmodule

`default_nettype wire
