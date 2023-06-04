module clk_div(
	input clkin,
	input [20:0] K,
	output clkout
);


logic [20:0] cntr;


always@(psoedge clk) begin
	if(cntr<K) 	cntr<=cntr+1;
	else 		cntr<=0;

end

endmodule