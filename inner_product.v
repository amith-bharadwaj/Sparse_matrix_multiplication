`timescale 1ns / 1ps

module matrix_inner_product #(parameter N = 3)(input clk
);
    reg [0:7] A[0:N-1][0:N-1]; 
    reg [0:7] B[0:N-1][0:N-1]; 
    reg [0:7] Result_InnerProduct[0:N-1][0:N-1] ;
        reg [0:7] Innerproduct[0:N-1][0:N-1] ;
    reg [7:0] data1 [0:8];
    reg [7:0] data2 [0:8];
    reg [7:0] mem1 [1:9];
    reg [7:0] mem2 [1:9];
    reg [3:0] address1,address2;
    wire [7:0] dina1,dina2;
    wire [7:0] douta1,douta2;
reg [0:31] i,j,k;



initial begin
address1=0;
address2=0;
k=0;
    for (i=0;i<9;i=i+1) begin
        mem1[i]=0;
        mem2[i]=0;
    end
    
    for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin     
		          A[i][j]=0;		          		               
            end
    end
    
    for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin     
		          B[i][j]=0;		          		               
            end
    end
        // Initialize result matrix C to zero
    for (i = 0; i < N; i = i + 1) begin
        for (j = 0; j < N; j = j + 1) begin
            Result_InnerProduct[i][j] = 0;
        end
    end
    
    
    
end

blk_mem_gen_0 blk_mem_1 (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(address1),  // input wire [3 : 0] addra
  .dina(dina1),    // input wire [7 : 0] dina
  .douta(douta1)  // output wire [7 : 0] douta
);

blk_mem_gen_1 blk_mem_2 (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(address2),  // input wire [3 : 0] addra
  .dina(dina2),    // input wire [7 : 0] dina
  .douta(douta2)  // output wire [7 : 0] douta
);

ila_0 your_instance_name (
	.clk(clk), // input wire clk


	.probe0( Innerproduct[0][0]), // input wire [7:0]  probe0  
	.probe1( Innerproduct[0][1]), // input wire [7:0]  probe1 
	.probe2( Innerproduct[0][2]), // input wire [7:0]  probe2 
	.probe3( Innerproduct[1][0]), // input wire [7:0]  probe3 
	.probe4( Innerproduct[1][1]), // input wire [7:0]  probe4 
	.probe5( Innerproduct[1][2]), // input wire [7:0]  probe5 
	.probe6( Innerproduct[2][0]), // input wire [7:0]  probe6 
	.probe7( Innerproduct[2][1]), // input wire [7:0]  probe7 
	.probe8( Innerproduct[2][2]) // input wire [7:0]  probe8
);

    
always @(posedge clk)begin

        mem1[address1]=douta1;
        mem2[address2]=douta2;
		address1=address1+4'b0001;
		address2=address2+4'b0001;
		
      for (k = 0; k < 9; k = k + 1) begin   
              data1[k]=mem1[k+1];
              data2[k]=mem2[k+1]; 
             end
        k=0;
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
		          A[i][j]=data1[k];
		          B[i][j]=data2[k];
		          k=k+1;
		       end
           end
           
          for (i = 0; i < 3; i = i + 1) begin
        for (j = 0; j < 3; j = j + 1) begin
    
            Result_InnerProduct[i][j] = 0;
            
        end
    end      
    // Perform matrix multiplication
    for (i = 0; i < N; i = i + 1) begin
        for (j = 0; j < N; j = j + 1) begin
            for (k = 0; k < N; k = k + 1) begin
                Result_InnerProduct[i][j] = (A[i][k] * B[k][j])+ Result_InnerProduct[i][j];
            end
        end
    end
end

always@(posedge clk) begin
for (i = 0; i < N; i = i + 1) begin
        for (j = 0; j < N; j = j + 1) begin
            Innerproduct[i][j]=Result_InnerProduct[i][j];
        end
    end

end
  

endmodule