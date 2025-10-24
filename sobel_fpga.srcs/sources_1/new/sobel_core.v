`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2025 21:47:02
// Design Name: 
// Module Name: sobel_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// sobel_core.v
module sobel_core (
    input clk, rstn,
    input [7:0] p00, p01, p02,
    input [7:0] p10, p11, p12,
    input [7:0] p20, p21, p22,
    output reg signed [15:0] gx,
    output reg signed [15:0] gy
);
    always @(posedge clk) begin
        if (!rstn) begin
            gx <= 16'sd0;
            gy <= 16'sd0;
        end else begin
            gx <= -$signed({8'b0,p00}) + $signed({8'b0,p02})
                  - ($signed({8'b0,p10}) <<< 1) + ($signed({8'b0,p12}) <<< 1)
                  - $signed({8'b0,p20}) + $signed({8'b0,p22});
            gy <= -$signed({8'b0,p00}) - ($signed({8'b0,p01}) <<< 1) - $signed({8'b0,p02})
                  + $signed({8'b0,p20}) + ($signed({8'b0,p21}) <<< 1) + $signed({8'b0,p22});
        end
    end
endmodule

