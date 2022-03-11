module conv1(data_in, data_out, clk, rst_n);
input signed [15:0] data_in;
input clk, rst_n;
output reg signed [31:0] data_out;

reg signed [15:0]buffer[63:0]; // line buffer 
reg [5:0] ptr; 				   // used for circular queue
reg [5:0] offset[8:0];		   // used for locating input data
reg state;					   // checks whether data is ready
always @(posedge clk) begin
	if(rst_n==0) begin // initialzation
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
		if(state==1'b0) begin // data waiting state
			if(ptr==6'd58) begin
				state<=1'b1;
				ptr<=ptr+1;
			end
			else begin
				state<=1'b0;
				ptr<=ptr+1;
			end
		end
		else begin // output generating state
			ptr<=ptr+1;
			data_out<=(-4972*buffer[offset[0]]
		              -622*buffer[offset[1]]
				      +2988*buffer[offset[2]])
				     +(-2478*buffer[offset[3]]
				      +1703*buffer[offset[4]]
				      +2519*buffer[offset[5]])
				     +(2008*buffer[offset[6]]
				      +1748*buffer[offset[7]]
				      +79*buffer[offset[8]])-58730196;
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
