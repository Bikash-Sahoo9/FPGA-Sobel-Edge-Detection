//tb_sobel.v
`timescale 1ns/1ps
module tb_sobel;
  reg clk;
  reg rstn;
  reg [7:0] in_pixel;
  reg in_valid;
  wire in_ready;
  wire [7:0] out_pixel;
  wire out_valid;

  // Instantiate DUT
  sobel_top dut (
    .clk(clk), .rstn(rstn),
    .in_pixel(in_pixel), .in_valid(in_valid),
    .in_ready(in_ready),
    .out_pixel(out_pixel), .out_valid(out_valid),
    .out_ready(1'b1)
  );

  // clock: 10 ns period -> 100 MHz
  initial begin clk = 0; forever #5 clk = ~clk; end

  // memory for image: 16x16 = 256 pixels
  reg [7:0] img [0:255];
  integer i, f;

  // load memory from file image.mem (hex)
  initial begin
    // create a simple test image if file is not found
    $readmemh("image.mem", img);
  end

  initial begin
    // dump waves
    $dumpfile("tb_sobel.vcd");
    $dumpvars(0, tb_sobel);

    // reset
    rstn = 0;
    in_valid = 0;
    in_pixel = 8'd0;
    #100;
    rstn = 1;
    #20;

    // stream image pixels into DUT
    for (i = 0; i < 256; i = i + 1) begin
      in_pixel = img[i];
      in_valid = 1;
      @(posedge clk);
    end
    in_valid = 0;

    // wait some cycles for processing
    #500;
    $writememh("out_pixels.mem", img); // write something if desired
    $finish;
  end
endmodule
