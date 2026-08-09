module MIDS (
    input  wire        clk,
    input  wire [15:0] input_data,
    input  wire [15:0] reference,
    input  wire        error_in,
    output wire        recognition,
    output reg  [3:0]  threshold,
    output reg  [4:0]  matched_pixels,
    output reg         correction_done
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

reg previous_output = 0;
reg correcting = 0;

always @(posedge clk) begin

    correction_done <= 1'b0;

    if (error_in && !correcting) begin
        previous_output <= recognition;
        threshold <= 4'd15;
        correcting <= 1'b1;
    end

    else if (correcting) begin
        if (recognition != previous_output) begin
            correcting <= 1'b0;
            correction_done <= 1'b1;
        end
        else begin
            threshold <= threshold - 4'd1;
        end
    end
end

endmodule