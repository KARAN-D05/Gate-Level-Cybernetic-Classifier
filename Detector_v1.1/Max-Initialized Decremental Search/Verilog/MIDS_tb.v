`timescale 1ns/1ps

module testbench;

    reg clk;
    reg [15:0] input_data;
    reg [15:0] reference;
    reg error_in;
    wire recognition;
    wire [3:0] threshold;
    wire [4:0] matched_pixels;
    wire correction_done;

    MIDS dut (
        .clk(clk),
        .input_data(input_data),
        .reference(reference),
        .error_in(error_in),
        .recognition(recognition),
        .threshold(threshold),
        .matched_pixels(matched_pixels),
        .correction_done(correction_done)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim.vcd");
        $dumpvars(0, testbench);

        clk = 0;
        error_in = 0;

        // Create M = 2
        // input_data and reference differ in 14 positions
        input_data = 16'b0000_0000_0000_0011;
        reference  = 16'b1111_1111_1111_1111;

        // Initial threshold = 14
        dut.threshold = 4'd14;

        #10;

        $display("Initial:");
        $display("M = %d, T = %d, Recognition = %b",
                 matched_pixels, threshold, recognition);

        error_in = 1;

        #10;

        error_in = 0;

        while (!correction_done) begin
            @(posedge clk);

            #1;

            $display("Time=%0t | M=%d | T=%d | Recognition=%b | Correcting=%b | Done=%b",
                     $time,
                     matched_pixels,
                     threshold,
                     recognition,
                     dut.correcting,
                     correction_done);
        end

        #10;

        $display("--------------------------------");
        $display("Correction complete!");
        $display("Final M = %d", matched_pixels);
        $display("Final T = %d", threshold);
        $display("Final Recognition = %b", recognition);
        $display("--------------------------------");

        $finish;
    end

endmodule