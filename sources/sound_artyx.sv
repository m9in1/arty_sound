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


always(posedge clk or negedge rstn) begin
	if(rstn) 	count<=count + 1;
	else		count<=0;

end


endmodule