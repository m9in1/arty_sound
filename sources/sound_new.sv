module sound_new(
	input clk,
	input aud_en,
	input [31:0] data_i,
	output pwm
		);


	logic [9:0] cntr;
	logic [3:0] duty [7:0];
	assign {duty[3], duty[2],duty[1], duty[0]} = aud_en ? {data_i[31:24], data_i[23:16], data_i[15:8], data_i[7:0]} : 0;

	always@(posedge clk) begin
		if(&cntr!=1) begin
			cntr<=cntr+1;

		end


	end


	assign pwm = (cntr[7:0]<=duty[cntr[9:8]]);

endmodule