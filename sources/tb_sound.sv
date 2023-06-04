`timescale 1ns/1ps

module tb_sound();
	logic clk, rstn, aud_en, temp_clk;
	logic aud_pwm;


	sound_artyx sound(
	.CLK100MHZ(clk),//input CLK100MHZ,
	.BTNC(rstn),//input BTNC,
	.SW(aud_en),//input [0:0]SW,
   // .temp_clk(temp_clk),
	.AUD_PWM(aud_pwm)//output AUD_PWM
);

	always #5 clk=~clk;
    always #5120 temp_clk=~temp_clk;
    
	task waitin(input integer num_clk);
		integer i;
		for(i = 0; i<num_clk; i=i+1) begin
			@(posedge clk);

		end

	endtask
    
    task waitin_mus(input integer num_clk);
        integer i;
		for(i = 0; i<num_clk; i=i+1) begin
			@(posedge temp_clk);

		end
    
    endtask

	initial begin
		clk=0;
		aud_en=0;
		rstn=1;
		waitin(2);
		rstn=0;
		waitin(2);
		rstn=1;
		waitin(3);
		aud_en=1;
		
		


	end

endmodule