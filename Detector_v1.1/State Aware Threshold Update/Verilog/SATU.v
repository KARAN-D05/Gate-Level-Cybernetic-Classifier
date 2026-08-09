module SATU (
    input  wire        clk,
    input  wire [15:0] input_data,
    input  wire [15:0] reference,
    input  wire        error_in,
    output wire        recognition,
    output reg  [3:0]  threshold,
    output reg  [4:0]  matched_pixels
);

wire [15:0] match_bits;
assign match_bits = ~(input_data ^ reference);

integer i = 0;

always @(*) begin
    matched_pixels = 0;

    for (i = 0; i < 16; i = i + 1)
        matched_pixels = matched_pixels + match_bits[i];
end

assign recognition = (matched_pixels > {1'b0, threshold});

always @(posedge clk) begin

    if (error_in) begin

        // Current output is 0:
        // Need recognition -> T = M - 1
        if (!recognition) begin
            threshold <= matched_pixels - 5'd1;
        end
        // Current output is 1:
        // Need non-recognition -> T = M
        else begin
            threshold <= matched_pixels;
        end
    end
end

endmodule