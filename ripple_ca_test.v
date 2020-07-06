//16-bit adder using 4-bit adder:test bench
//Author: Mukti Mehta

module ripple_ca_test;
reg [3:0] x,y;
reg cin;
wire [3:0] s;
wire cout;

adder4 ADD(s,cout,x,y,cin);
initial 
begin
$monitor($time,"x=%b,y=%b,cin=%b,s=%b,cout=%b",x,y,cin,s,cout);
#5 x=4'b0010;y=4'b0001; cin=1'b1;
#5 x=4'b0100;y=4'b0010;
#5 x=4'b1000;y=4'b0000; 
#5 $finish;
end 
endmodule
