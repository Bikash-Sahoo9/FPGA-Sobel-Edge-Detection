`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2025 21:47:02
// Design Name: 
// Module Name: sobel_top
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

// sobel_top.v
module sobel_top (
    input  wire        clk,
    input  wire        rstn,
    input  wire [7:0]  in_pixel,
    input  wire        in_valid,
    output wire        in_ready,
    output wire [7:0]  out_pixel,
    output wire        out_valid,
    input  wire        out_ready
);
    wire [7:0] p00, p01, p02;
    wire [7:0] p10, p11, p12;
    wire [7:0] p20, p21, p22;
    wire       center_valid;

    line_buffer lb (
        .clk(clk), .rstn(rstn),
        .in_pixel(in_pixel), .in_valid(in_valid), .in_ready(in_ready),
        .p00(p00), .p01(p01), .p02(p02),
        .p10(p10), .p11(p11), .p12(p12),
        .p20(p20), .p21(p21), .p22(p22),
        .out_valid(center_valid)
    );

    wire signed [15:0] gx;
    wire signed [15:0] gy;
    sobel_core sc (
        .clk(clk), .rstn(rstn),
        .p00(p00), .p01(p01), .p02(p02),
        .p10(p10), .p11(p11), .p12(p12),
        .p20(p20), .p21(p21), .p22(p22),
        .gx(gx), .gy(gy)
    );

    magnitude_thresh mt (
        .clk(clk), .rstn(rstn),
        .gx(gx), .gy(gy), .in_valid(center_valid),
        .edge_pixel(out_pixel), .edge_valid(out_valid)
    );

    // simple handshake: tell input it's always ready
    assign in_ready = 1'b1;

endmodule

