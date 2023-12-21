`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2023 15:06:18
// Design Name: 
// Module Name: axi_gpio_tb
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


//module axi_gpio_tb(

//    );
//endmodule


`timescale 1ns/1ps

module axi_gpio_slave_tb;

    // AXI4-Lite Master signals
    reg aclk;
    reg aresetn;
    reg [31:0] awaddr;
    reg [7:0] awprot;
    reg awvalid;
    wire awready;
    reg [31:0] wdata;
    reg [3:0] wstrb;
    reg wvalid;
    wire wready;
    wire [1:0] bresp;
    wire bvalid;
    reg bready;
    reg [31:0] araddr;
    reg [7:0] arprot;
    reg arvalid;
    wire arready;
    wire [31:0] rdata;
    wire [1:0] rresp;
    wire rvalid;
    reg rready;

    // GPIO output signal
    wire [31:0] gpio_out;

    // Instantiate the DUT
    axi_gpio_slave dut (
        .S_AXI_ACLK(aclk),
        .S_AXI_ARESETN(aresetn),
        .S_AXI_AWADDR(awaddr),
        .S_AXI_AWPROT(awprot),
        .S_AXI_AWVALID(awvalid),
        .S_AXI_AWREADY(awready),
        .S_AXI_WDATA(wdata),
        .S_AXI_WSTRB(wstrb),
        .S_AXI_WVALID(wvalid),
        .S_AXI_WREADY(wready),
        .S_AXI_BRESP(bresp),
        .S_AXI_BVALID(bvalid),
        .S_AXI_BREADY(bready),
        .S_AXI_ARADDR(araddr),
        .S_AXI_ARPROT(arprot),
        .S_AXI_ARVALID(arvalid),
        .S_AXI_ARREADY(arready),
        .S_AXI_RDATA(rdata),
        .S_AXI_RRESP(rresp),
        .S_AXI_RVALID(rvalid),
        .S_AXI_RREADY(rready),
        .gpio_out(gpio_out)
    );

    // Clock generation
    initial begin
        aclk = 0;
        forever #5 aclk = ~aclk;
    end

    // Reset generation
    initial begin
        aresetn = 0;
        #10;
        aresetn = 1;
    end

    // Write transaction
    initial begin
        awaddr = 32'h00000000;
        awprot = 8'h00;
        awvalid = 1'b0;
        wdata = 32'h00000000;
        wstrb = 4'b0000;
        wvalid = 1'b0;
        bready = 1'b0;
        @(negedge aclk);
        awaddr = 32'h00000000;
        awvalid = 1'b1;
        wdata = 32'h00000001;
        wstrb = 4'b1111;
        wvalid = 1'b1;
        bready = 1'b0;
        repeat (2) @(negedge aclk);
        awvalid = 1'b0;
        wvalid = 1'b0;
        bready = 1'b1;
        @(negedge aclk);
        bready = 1'b0;
        repeat (2) @(posedge aclk);
    end

    // Read transaction
    initial begin
        araddr = 32'h00000000;
        arprot = 8'h00;
        arvalid = 1'b1;
        repeat (2) @(posedge aclk);
        arvalid = 1'b0;
        repeat (2) @(posedge aclk);
        if (rready) begin
            rready = 1'b0;
        end
        repeat (2) @(posedge aclk);
    end

    // End simulation
    initial begin
        #100;
        $finish;
    end

endmodule

//I hope this helps! Let me know if you have any other questions.

//Source: Conversation with Bing, 14/12/2023
//(1) write AXI4-Lite testbench - Xilinx Support. https://support.xilinx.com/s/question/0D52E00006hpcW0SAI/write-axi4lite-testbench?language=en_US.
//(2) GitHub - schang412/verilog-gpio. https://github.com/schang412/verilog-gpio.
//(3) system verilog - AXI Verification IP Test Example - Stack Overflow. https://stackoverflow.com/questions/64050121/axi-verification-ip-test-example.
//(4) GitHub - alexforencich/verilog-axi: Verilog AXI components for FPGA .... https://github.com/alexforencich/verilog-axi.
//(5) AXI Basics 2 - Simulating AXI interfaces with the AXI Verification IP .... https://support.xilinx.com/s/article/1053935?language=en_US.