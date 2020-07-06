//D-type latch:test bench
//Author: Mukti Mehta

module d_latch_test;
reg d,en;
wire q;
d_latch LAT(d,q,en);
initial
begin
$monitor($time,"d=%b,q=%b,en=%b",d,q,en);
d=1'bx;en=1'b0;
#5 d=1'b0;en=1'b1;
#5 d=1'b1;en=1'b1;
end
endmodule

