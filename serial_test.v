module serial_test;
reg clk,reset,a,b;
wire s,cy;
serial_adder SED(a,b,reset,clk,s,cy);

initial 
begin 
clk=1'b0;
reset=1'b1;
#15 reset=1'b0;
end
always #5 clk=~clk;
initial
begin
#12 a=0;
#10 b=0;
#10 a=1;
#10 b=0;
#10 a=0;
#10 b=1;
#10 $finish;
end
endmodule
