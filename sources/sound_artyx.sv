module sound_artyx(
	input CLK100MHZ,
	input BTNC,
	input [0:0]SW,

	output AUD_PWM
);

logic clkdived;
logic [31:0] count;
logic [31:0] rd_data;

sound #
	(.DATA_WIDTH(8),	
	.FIFO_DATA_WIDTH(32))
	sound(
			.clk(CLK100MHZ),
			.rstn(BTNC),
			.aud_en(SW[0]),
			.fifo_rd_data(rd_data),
			.aud_pwm(AUD_PWM)
			);

tact_data data(
	.A(count),
	.RD(rd_data)
	);



clk_div clk_div(
	.clkin(CLK100MHZ),
	.rstn(BTNC),
	.K(2),
	.clkout(clkdived)
	);


always@(posedge clkdived or negedge BTNC) begin
	if(BTNC) 	count<=count + 1;
	else		count<=0;

end


endmodule