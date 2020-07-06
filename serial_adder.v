module serial_adder(a,b,reset,clk,s,cy);
input a,b,clk,reset;
output s,cy;
parameter s0=0,s1=1;
reg [0:1] ps,ns;
assign {cy,s}=a+b;

always @(posedge clk or posedge reset)
if(reset)
ps<=s0;
else
ps<=s1;

always @(ns,s,cy)
case(ps)
s0:begin
if (s<= 0 & cy<=0)
ns<=s0;
else if (s<=1 & cy<=0)
ns<=s0;
else if (s<=0 & cy<=1)
ns<=s1;
else
ns<=s0;
end

s1:begin
if (s<= 0 & cy<=1)
ns<=s1;
else if (s<=1 & cy<=1)
ns<=s1;
else if (s<=1 & cy<=0)
ns<=s0;
else
ns<=s1;
end 
endcase
endmodule
 


