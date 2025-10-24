`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2025 21:47:02
// Design Name: 
// Module Name: magnitude_thresh
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

// magnitude_thresh.v
module magnitude_thresh (
    input clk, rstn,
    input signed [15:0] gx, gy,
    input in_valid,
    output reg [7:0] edge_pixel,
    output reg edge_valid
);
    reg [15:0] abs_gx, abs_gy;
    reg [15:0] mag;
    parameter THRESH = 16'd400; // start low for testing; tune later

    always @(posedge clk) begin
        if (!rstn) begin
            edge_pixel <= 8'd0;
            edge_valid <= 1'b0;
            abs_gx <= 16'd0;
            abs_gy <= 16'd0;
            mag <= 16'd0;
        end else begin
            if (in_valid) begin
                abs_gx <= gx[15] ? -gx : gx;
                abs_gy <= gy[15] ? -gy : gy;
                mag <= abs_gx + abs_gy;
                edge_valid <= 1'b1;
                edge_pixel <= (mag > THRESH) ? 8'hFF : 8'h00;
            end else begin
                edge_valid <= 1'b0;
            end
        end
    end
endmodule
