module clk_div(
	input clkin,
	input rstn,
	input [20:0] K,
	output logic clkout
);


logic [20:0] cntr;
logic state;

always@(posedge clkin or negedge rstn) begin
    if(rstn) begin
        if(cntr<(K-1)) 	begin
           cntr<=cntr+1;
           clkout<=state;
        end
        else 	begin	
            cntr<=0;
            state<=~state;
        end
    end else begin
        cntr<=0;
        state<=0;    
    end
end

endmodule