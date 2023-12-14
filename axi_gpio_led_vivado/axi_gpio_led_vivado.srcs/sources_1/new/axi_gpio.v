`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2023 17:00:37
// Design Name: 
// Module Name: axi_gpio
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

module axi_gpio
#(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 32
)
(
    input wire S_AXI_ACLK,
    input wire S_AXI_ARESETN,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
    input wire [7:0] S_AXI_AWPROT,
    input wire S_AXI_AWVALID,
    output wire S_AXI_AWREADY,
    input wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
    input wire [C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
    input wire S_AXI_WVALID,
    output wire S_AXI_WREADY,
    output wire [1:0] S_AXI_BRESP,
    output wire S_AXI_BVALID,
    input wire S_AXI_BREADY,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
    input wire [7:0] S_AXI_ARPROT,
    input wire S_AXI_ARVALID,
    output wire S_AXI_ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
    output wire [1:0] S_AXI_RRESP,
    output wire S_AXI_RVALID,
    input wire S_AXI_RREADY,
    output wire [31:0] gpio_out
);

    reg [31:0] gpio_reg;

    assign S_AXI_AWREADY = 1'b1;
    assign S_AXI_WREADY = 1'b1;
    assign S_AXI_BRESP = 2'b00;
    assign S_AXI_BVALID = 1'b0;
    assign S_AXI_ARREADY = 1'b1;
    assign S_AXI_RRESP = 2'b00;
    assign S_AXI_RVALID = 1'b1;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            gpio_reg <= 32'h0;
        end else if (S_AXI_AWVALID && S_AXI_WVALID) begin
            gpio_reg <= S_AXI_WDATA;
        end else if (S_AXI_ARVALID) begin
            S_AXI_RDATA <= gpio_reg;
        end
    end

    assign gpio_out = gpio_reg;

endmodule

//I hope this helps! Let me know if you have any other questions.

//Source: Conversation with Bing, 14/12/2023
//(1) write AXI4-Lite testbench - Xilinx Support. https://support.xilinx.com/s/question/0D52E00006hpcW0SAI/write-axi4lite-testbench?language=en_US.
//(2) GitHub - schang412/verilog-gpio. https://github.com/schang412/verilog-gpio.
//(3) system verilog - AXI Verification IP Test Example - Stack Overflow. https://stackoverflow.com/questions/64050121/axi-verification-ip-test-example.
//(4) GitHub - alexforencich/verilog-axi: Verilog AXI components for FPGA .... https://github.com/alexforencich/verilog-axi.
//(5) AXI Basics 2 - Simulating AXI interfaces with the AXI Verification IP .... https://support.xilinx.com/s/article/1053935?language=en_US.
