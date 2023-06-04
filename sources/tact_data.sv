module tact_data(
input [31:0] A,
output logic [31:0] RD
    );
    

    logic [31:0] RAM [0:255]; 
    initial begin
        $readmemb("music.bin", RAM);
    end
    
    assign RD[31:0] = RAM[A];
    
endmodule