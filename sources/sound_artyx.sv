module sound_artyx(
	input CLK100MHZ,
	input BTNC,
	input [0:0]SW,
    //input temp_clk,
	output AUD_PWM
);

logic clkdived_data, clkdived_all;
logic [31:0] count;
logic [31:0] rd_data;
logic aud_en_sync;


sound_new
	sound(
			.clk(clkdived_all),
			.aud_en(aud_en_sync),
			.rstn(BTNC),
			.data_i(rd_data),
			.pwm(AUD_PWM)
			);

tact_data data(
	.A(count),
	.RD(rd_data)
	);



clk_div 
         #(.WIDTH(11),// Максимальное значение счетчика: (2 ^ WIDTH) -1. Должен встретить N = <(2 ^ WIDTH)
          .N(1024))
clk_div_data(
	.clk(clkdived_all),
	.rst_n(BTNC),
	.o_clk(clkdived_data)
	);

clk_div  #(.WIDTH(3),// Максимальное значение счетчика: (2 ^ WIDTH) -1. Должен встретить N = <(2 ^ WIDTH)
          .N(8))
          clk_div_all(
	.clk(CLK100MHZ),
	.rst_n(BTNC),
	.o_clk(clkdived_all)
	); 


sync_trig sync(
	.clk_all(clkdived_all),
	.clk_data(clkdived_data),
	.aud_en(SW[0]),
	.aud_en_sync(aud_en_sync)

	);


always@(posedge clkdived_data or negedge BTNC) begin
	if(BTNC&aud_en_sync) 	 count<=count + 1;
	else		             count<=0;

end


endmodule