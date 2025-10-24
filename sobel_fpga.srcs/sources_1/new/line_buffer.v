`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2025 21:47:02
// Design Name: 
// Module Name: line_buffer
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

// line_buffer.v
module line_buffer (
    input clk, rstn,
    input [7:0] in_pixel,
    input in_valid,
    output reg in_ready,
    output [7:0] p00, p01, p02,
    output [7:0] p10, p11, p12,
    output [7:0] p20, p21, p22,
    output reg out_valid
);
    // Parameters for a small test image width
    parameter IMG_WIDTH = 16;
    reg [7:0] row0 [0:IMG_WIDTH-1];
    reg [7:0] row1 [0:IMG_WIDTH-1];
    reg [7:0] row2 [0:IMG_WIDTH-1];
    integer write_ptr;
    integer i;

    reg [7:0] shift0, shift1, shift2;

    // default outputs
    assign p00 = row0[write_ptr];
    assign p01 = (write_ptr>0) ? row0[write_ptr-1] : 8'd0;
    assign p02 = (write_ptr>1) ? row0[write_ptr-2] : 8'd0;

    assign p10 = row1[write_ptr];
    assign p11 = (write_ptr>0) ? row1[write_ptr-1] : 8'd0;
    assign p12 = (write_ptr>1) ? row1[write_ptr-2] : 8'd0;

    assign p20 = row2[write_ptr];
    assign p21 = (write_ptr>0) ? row2[write_ptr-1] : 8'd0;
    assign p22 = (write_ptr>1) ? row2[write_ptr-2] : 8'd0;

    initial begin
        in_ready = 1'b0;
        out_valid = 1'b0;
        write_ptr = 0;
        for (i=0;i<IMG_WIDTH;i=i+1) begin row0[i]=0; row1[i]=0; row2[i]=0; end
    end

    always @(posedge clk) begin
        if (!rstn) begin
            write_ptr <= 0;
            in_ready <= 1;
            out_valid <= 0;
        end else begin
            if (in_valid) begin
                // rotate rows down: row2 <= row1, row1 <= row0, row0[new] <= in_pixel
                // implement by writing into arrays with moving pointer (simple)
                // For simplicity, we push columns: write into row0, then after IMG_WIDTH shift indexes
                row2[write_ptr] <= row1[write_ptr];
                row1[write_ptr] <= row0[write_ptr];
                row0[write_ptr] <= in_pixel;
                // advance pointer
                if (write_ptr == IMG_WIDTH-1) begin
                    write_ptr <= 0;
                    out_valid <= 1; // a full column has been filled - window valid
                end else begin
                    write_ptr <= write_ptr + 1;
                    out_valid <= 0;
                end
            end
        end
    end
endmodule
