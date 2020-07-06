module seq_d1(x,clk,reset,z);
input x,clk,reset;
output reg z;
reg [0:2] ps,ns;
parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5;

always @(posedge clk or posedge reset)
if(reset) ps<=s0;
else ps<=ns;
always @(ps,x)
case(ps)
s0:begin
z=x?0:0;
ns=x?s1:s0;
end
s1:begin
z=x?0:0;
ns=x?s1:s2;
end
s2:begin
z=x?0:0;
ns=x?s3:s2;
end
s3:begin
z=x?0:0;
ns=x?s3:s4;
end
s4:begin
z=x?0:0;
ns=x?s5:s4;
end
s5:begin
z=x?0:1;
ns=x?s0:s4;
end
endcase
endmodule



