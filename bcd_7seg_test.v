//Author: Mukti Mehta
//BCD to 7-segment LED: Test bench

module bcd_7seg_test;
reg [3:0] bcd;
wire [6:0] seg;
bcd_7seg BCD(bcd,seg);
initial
begin
$monitor($time,"bcd=%b,seg=%b",bcd,seg);
bcd = 4'b0001;
#5 bcd = 4'b0010;
#5 bcd = 4'b0110;
#5 bcd = 4'b1100;
#50 $finish;
end
endmodule
