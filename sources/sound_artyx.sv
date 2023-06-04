module sound_artyx(
	input CLK100MHZ,
	input BTNC,
	input [0:0]SW,

	output AUD_PWM
);


sound #
	(.DATA_WIDTH(8),	
	.FIFO_DATA_WIDTH(32))
	sound(
			.clk(clkdived),
			.rstn(BTNC),
			.aud_en(SW[0]),
			.fifo_rd_data(rd_data),
			.aud_pwm(AUD_PWM)
			);

tact_data data(
	.A(count),
	.RD(rd_data)
	);

logic clkdived;

clk_div clk_div(
	.clkin(CLK100MHZ),
	.K(20000),
	.clkout(clkdived)
	);


always(posedge clkdived or negedge rstn) begin
	if(rstn) 	count<=count + 1;
	else		count<=0;

end


endmodule