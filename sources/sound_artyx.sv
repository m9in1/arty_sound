module sound_artyx(
	input CLK100MHZ,
	input BTNC,
	input [0:0]SW,
    //input temp_clk,
    output [15:0]LED,
	output AUD_PWM
);


logic rstn;
logic clkdived_data, clkdived_all;
logic [31:0] count;
logic [31:0] rd_data;
logic aud_en_sync;
assign rstn=!BTNC;

sound_new
	sound(
			.clk(clkdived_all),
			.aud_en(aud_en_sync),
			.rstn(rstn),
			.data_i(rd_data),
			.pwm(AUD_PWM)
			);

tact_data data(
			.A(count),
			.clk(clkdived_data),
			.RD(rd_data)
	);



clk_div 
         #(.WIDTH(11),
          .N(1024))
clk_div_data(
			.clk(clkdived_all),
			.rst_n(rstn),
			.o_clk(clkdived_data)
			);


clk_div  #(.WIDTH(4),
          .N(4))
clk_div_all(
			.clk(CLK100MHZ),
			.rst_n(rstn),
			.o_clk(clkdived_all)
			); 


sync_trig sync(
			.clk_all(clkdived_all),
			.clk_data(clkdived_data),
			.aud_en(SW[0]),
			.aud_en_sync(aud_en_sync)
			);



counter_data cntrd(
			.clk(clkdived_data),
			.rstn(rstn),
			.en(aud_en_sync),
			.addr(count)
			);

assign LED [14:0] = rd_data[14:0];
assign LED [15:15] = BTNC; 




// always@(posedge clkdived_data or negedge rstn) begin
// 	if(rstn&aud_en_sync) 	 count<=count + 1;
// 	else		             count<=0;

// end


endmodule