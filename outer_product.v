`timescale 1ns / 1ps

module matrix_outer_product #(parameter N = 3)(input clk);
    reg [0:7] A[0:N-1][0:N-1]; 
    reg [0:7] B[0:N-1][0:N-1]; 
    reg [0:15] C_out0[0:N-1][0:N-1] ;
    reg [0:15] C_out1[0:N-1][0:N-1] ;
    reg [0:15] C_out2[0:N-1][0:N-1] ;
    reg [0:15] result_OuterProduct[0:N-1][0:N-1] ;
    reg [7:0] data1 [0:8];
    reg [7:0] data2 [0:8];   
    reg [3:0] address1,address2;
    wire [7:0] dina1,dina2;
    wire [7:0] douta1,douta2;
    reg [7:0] mem1 [1:9];
    reg [7:0] mem2 [1:9];

reg [0:31] i,j,k;

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

ila_0 ila_instance (
	.clk(clk), // input wire clk


	.probe0(result_OuterProduct[0][0]), // input wire [7:0]  probe0  
	.probe1(result_OuterProduct[0][1]), // input wire [7:0]  probe1 
	.probe2(result_OuterProduct[0][2]), // input wire [7:0]  probe2 
	.probe3(result_OuterProduct[1][0]), // input wire [7:0]  probe3 
	.probe4(result_OuterProduct[1][1]), // input wire [7:0]  probe4 
	.probe5(result_OuterProduct[1][2]), // input wire [7:0]  probe5 
	.probe6(result_OuterProduct[2][0]), // input wire [7:0]  probe6 
	.probe7(result_OuterProduct[2][1]), // input wire [7:0]  probe7 
	.probe8(result_OuterProduct[2][2]) // input wire [0:0]  probe8
);

initial begin
address1=0;
address2=0;
       for (i = 0; i < 3; i = i + 1) begin
        for (j = 0; j < 3; j = j + 1) begin
           
            C_out0[i][j] = 0;
        end
    end
    
       for (i = 0; i < 3; i = i + 1) begin
        for (j = 0; j < 3; j = j + 1) begin   
            C_out1[i][j] = 0;  
        end
    end
    
       for (i = 0; i < 3; i = i + 1) begin
        for (j = 0; j < 3; j = j + 1) begin
           
            C_out2[i][j] = 0;
            result_OuterProduct[i][j]=0;
                        
            
        end
    end
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
    

end

    
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
end    
    

always @(posedge clk) begin



        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                C_out0[i][j] <=  A[i][0] * B[0][j];
            end
        end 
end

always @(posedge clk) begin

        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                C_out1[i][j] =   A[i][1] * B[1][j];
            end
        end 
end

always @(posedge clk) begin
 
        for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
            C_out2[i][j] =    A[i][2] * B[2][j];
            end
        end 
end



always @(posedge clk) begin
 for (i = 0; i < 3; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
            result_OuterProduct[i][j] =  C_out2[i][j]+C_out0[i][j] +C_out1[i][j];
            end
        end 
  end

endmodule