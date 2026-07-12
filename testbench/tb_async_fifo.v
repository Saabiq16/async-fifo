`timescale 1ns/1ps

module tb_async_fifo;

    parameter DSIZE = 8;
    parameter ASIZE = 4;
    localparam DEPTH = 1 << ASIZE;

    // DUT Signals
    reg  [DSIZE-1:0] wdata;
    wire [DSIZE-1:0] rdata;

    reg  wclk, rclk;
    reg  wrst_n, rrst_n;
    reg  winc, rinc;

    wire wfull;
    wire rempty;

    integer i;

    //-------------------------------------------------------
    // DUT
    //-------------------------------------------------------
    fifo #(
        .DSIZE(DSIZE),
        .ASIZE(ASIZE)
    ) dut (
        .wclk   (wclk),
        .rclk   (rclk),
        .wrst_n (wrst_n),
        .rrst_n (rrst_n),
        .winc   (winc),
        .rinc   (rinc),
        .wdata  (wdata),
        .rdata  (rdata),
        .wfull  (wfull),
        .rempty (rempty)
    );

    //-------------------------------------------------------
    // Clock Generation
    //-------------------------------------------------------
    initial wclk = 0;
    always #5 wclk = ~wclk;      // 10 ns period

    initial rclk = 0;
    always #8 rclk = ~rclk;      // 16 ns period

    //-------------------------------------------------------
    // Waveform Dump
    //-------------------------------------------------------
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb_async_fifo);
    end

    //-------------------------------------------------------
    // Monitor
    //-------------------------------------------------------
    initial begin
        $monitor("T=%0t | WDATA=%0d RDATA=%0d WINC=%b RINC=%b WFULL=%b REMPTY=%b",
                 $time, wdata, rdata, winc, rinc, wfull, rempty);
    end

    //-------------------------------------------------------
    // Test Sequence
    //-------------------------------------------------------
    initial begin

        // Initialize
        wrst_n = 0;
        rrst_n = 0;

        winc = 0;
        rinc = 0;
        wdata = 0;

        // Reset
        #20;
        wrst_n = 1;
        rrst_n = 1;

        //---------------------------------------------------
        // TEST 1 : Write a few words
        //---------------------------------------------------
        $display("\n========== TEST 1 : WRITE ==========");

        for(i=0;i<8;i=i+1) begin
            @(posedge wclk);
            wdata = i;
            winc  = 1;
            @(posedge wclk);
            winc  = 0;
        end

        #30;

        //---------------------------------------------------
        // TEST 2 : Read a few words
        //---------------------------------------------------
        $display("\n========== TEST 2 : READ ==========");

        for(i=0;i<8;i=i+1) begin
            @(posedge rclk);
            rinc = 1;
            @(posedge rclk);
            rinc = 0;
        end

        #30;

        //---------------------------------------------------
        // TEST 3 : Fill FIFO completely
        //---------------------------------------------------
        $display("\n========== TEST 3 : FULL ==========");

        for(i=0;i<DEPTH+2;i=i+1) begin
            @(posedge wclk);
            wdata = i + 20;
            winc = 1;
            @(posedge wclk);
            winc = 0;
        end

        #30;

        //---------------------------------------------------
        // TEST 4 : Empty FIFO completely
        //---------------------------------------------------
        $display("\n========== TEST 4 : EMPTY ==========");

        for(i=0;i<DEPTH+2;i=i+1) begin
            @(posedge rclk);
            rinc = 1;
            @(posedge rclk);
            rinc = 0;
        end

        #50;

        $display("\nSimulation Completed Successfully");
        $finish;

    end

endmodule