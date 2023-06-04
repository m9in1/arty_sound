`timescale 1ns / 1ps
module sound #(
parameter DATA_WIDTH = 8,
parameter FIFO_DATA_WIDTH = 32
) (
    input wire clk,
    input wire rstn,
    output wire aud_pwm,
    input reg aud_en,
    
    input [FIFO_DATA_WIDTH-1:0] fifo_rd_data
    );
    reg [DATA_WIDTH+1:0] count = 0;
    reg [DATA_WIDTH:0] duty [3:0];
    always@(posedge clk) begin
                if (&count == 1'b1) begin
                    count <= 0;
                    if (aud_en) begin
                        duty[0] <= fifo_rd_data[7:0];
                        duty[1] <= fifo_rd_data[15:8];
                        duty[2] <= fifo_rd_data[23:16];
                        duty[3] <= fifo_rd_data[31:24];
                    end
                end else count <= count + 1;
    end
    assign aud_pwm = count[DATA_WIDTH-1:0] <= duty[count[DATA_WIDTH+1:DATA_WIDTH]];
endmodule