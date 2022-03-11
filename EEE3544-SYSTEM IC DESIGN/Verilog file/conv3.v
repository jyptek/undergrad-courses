module conv3(data_in, data_out, clk, rst_n);
input signed [15:0] data_in;
input clk, rst_n;
output reg signed [31:0] data_out;

reg signed [15:0]buffer[63:0];
reg [5:0] ptr;
reg [5:0] offset[8:0];
reg state;
always @(posedge clk) begin
	if(rst_n==0) begin
		ptr<=0;
		offset[0]<=0;
		offset[1]<=1;
		offset[2]<=2;
		offset[3]<=28;
		offset[4]<=29;
		offset[5]<=30;
		offset[6]<=56;
		offset[7]<=57;
		offset[8]<=58;
		state<=1'b0;
	end
	else begin
		buffer[ptr]<=data_in;
		if(state==1'b0) begin
			if(ptr==6'd58) begin
				state<=1'b1;
				ptr<=ptr+1;
			end
			else begin
				state<=1'b0;
				ptr<=ptr+1;
			end
		end
		else begin
			ptr<=ptr+1;
			data_out<=(-6887*buffer[offset[0]]
		               -4375*buffer[offset[1]]+
				       1520*buffer[offset[2]])+(
				       -422*buffer[offset[3]]
				       -3946*buffer[offset[4]]
				       -5607*buffer[offset[5]])+(
				       5850*buffer[offset[6]]+
				       3699*buffer[offset[7]]+
				       119*buffer[offset[8]])-12478232;
			offset[0]<=offset[0]+1;
			offset[1]<=offset[1]+1;
			offset[2]<=offset[2]+1;
			offset[3]<=offset[3]+1;
			offset[4]<=offset[4]+1;
			offset[5]<=offset[5]+1;
			offset[6]<=offset[6]+1;
			offset[7]<=offset[7]+1;
			offset[8]<=offset[8]+1;
		end
	end
end
endmodule
