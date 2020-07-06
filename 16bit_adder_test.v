//16-bit adder using 4-bit adder:test bench
//Author: Mukti Mehta

module bit16_adder_test;
reg [15:0] x,y;
wire [15:0] z;
wire s,zr,cy,p,ov;
ALU DUT(x,y,z,s,zr,cy,p,ov);
initial 
begin
$monitor($time,"x=%h,y=%h,z=%h,s=%b,zr=%b,cy=%b,p=%b,ov=%b",x,y,z,s,zr,cy,p,ov);
#5 x=16'h8fff;y=16'h8000;
#5 x=16'h8ffe;y=16'h0002;
#5 x=16'haaaa;y=16'h5555; 
#5 $finish;
end 
endmodule
