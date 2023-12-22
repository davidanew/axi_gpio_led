`timescale 1ns / 1ps

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

    // Write and read transactions
    initial begin
    
        // Initialisation
        awaddr = 32'h00000000;
        awprot = 8'h00;
        awvalid = 1'b0;
        wdata = 32'h00000000;
        wstrb = 4'b0000;
        wvalid = 1'b0;
        bready = 1'b0;
        
        // Write transaction
        @(negedge aclk);
        // Set write address, data and valids
        awaddr = 32'h00000000;
        awvalid = 1'b1;
        wdata = 32'h00000001;
        wstrb = 4'b1111;
        wvalid = 1'b1;
        @(negedge aclk);
        // Slave will have asserted readys 
        assert(wready == 1'b1) else $error("Write data ready not asserted");
        assert(awready == 1'b1) else $error("Write address ready not asserted");
        @(negedge aclk);        
        // Slave would have cleared readys
        assert(wready == 1'b0) else $error("Write data ready not cleared");
        assert(awready == 1'b0) else $error("Write address ready not cleared");      
        // Clear valids
        awvalid = 1'b0;
        wvalid = 1'b0;
        // set write return channel as ready
        bready = 1'b1;
        // Slave would have set return channel valid
        assert(bvalid == 1'b1) else $error("Write return valid not set"); 
        @(negedge aclk);
        // Clear return channel ready
        bready = 1'b0;
        
        // Read transaction
        @(negedge aclk);
        // Set read address, data and valids
        araddr = 32'h00000000;
        arvalid = 1'b1;
        @(negedge aclk);
        // Slave will have asserted ready
        assert(arready == 1'b1) else $error("Read address ready not asserted");
        @(negedge aclk);
        // Slave would have de-asserted readys
        assert(arready == 1'b0) else $error("read address ready not cleared"); 
        // Clear valid
        arvalid = 1'b0;
        // set read return channel as ready
        rready = 1'b1;
        // Slave would have set return channel valid
        assert(rvalid == 1'b1) else $error("Read return valid not set");
        // Slave should have correct read value 
        assert(rvalid == 32'h00000001) else $error("Read return value not correct");
        @(negedge aclk);
        rready = 1'b0;
    end

    // End simulation
    initial begin
        #100;
        $finish;
    end

endmodule

