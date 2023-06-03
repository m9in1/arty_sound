module tact_data(
input [31:0] A,
output logic [31:0] RD
    );
    

    logic[7:0] A_to_word;
    logic [31:0] RAM [0:255]; 
    initial begin
        $readmemh("sound.bin", RAM);
    end
    
    assign RD[31:0] = RAM[A];
    
endmodule