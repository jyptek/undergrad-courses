module do_conv;

reg clk;
reg rst_n=1'b1;
reg signed [15:0] data_in;
wire signed [31:0] data_out1;
wire signed [31:0] data_out2;
wire signed [31:0] data_out3;

integer file_input, file_output, work_sequence,i;
reg [120:0]input_txt;
reg [120:0]output_txt;
conv1 example1(data_in, data_out1, clk, rst_n);
conv2 example2(data_in, data_out2, clk, rst_n);
conv3 example3(data_in, data_out3, clk, rst_n);

initial
begin
    clk = 1'b0;
    forever #50 clk = ~clk;
end

initial
begin
    work_sequence = $fopen("work_sequence.txt","r");
    for(i=0;i<20;i=i+1) begin
       $fscanf(work_sequence,"%s",input_txt);
       $fscanf(work_sequence,"%s",output_txt);
       file_output = $fopen(output_txt, "w");
       file_input = $fopen(input_txt, "r");
       rst_n=1'b0; 
       #100 rst_n=1'b1;
       repeat (60) begin
              $fscanf(file_input, "%6d", data_in); #100;
       end
       repeat (26) begin
              repeat (26) begin
                     $fscanf(file_input, "%6d", data_in);
                     $fdisplay(file_output, "%12d", data_out1);#100;
              end
              $fscanf(file_input, "%6d", data_in);#100;
              $fscanf(file_input, "%6d", data_in);#100;
       end
       $fclose(file_input);
       file_input = $fopen(input_txt, "r");
       rst_n=1'b0; 
       #100 rst_n=1'b1;
       repeat (60) begin
              $fscanf(file_input, "%6d", data_in); #100;
       end
       repeat (26) begin
              repeat (26) begin
                     $fscanf(file_input, "%6d", data_in);
                     $fdisplay(file_output, "%12d", data_out2);#100;
              end
              $fscanf(file_input, "%6d", data_in);#100;
              $fscanf(file_input, "%6d", data_in);#100;
       end
       $fclose(file_input);
       file_input = $fopen(input_txt, "r");
       rst_n=1'b0; 
       #100 rst_n=1'b1;
       repeat (60) begin
              $fscanf(file_input, "%6d", data_in); #100;
       end
       repeat (26) begin
              repeat (26) begin
                     $fscanf(file_input, "%6d", data_in);
                     $fdisplay(file_output, "%12d", data_out3);#100;
              end
              $fscanf(file_input, "%6d", data_in);#100;
              $fscanf(file_input, "%6d", data_in);#100;
       end
       $fclose(file_input);
       $fclose(file_output);
    end
    $finish;
end

endmodule





