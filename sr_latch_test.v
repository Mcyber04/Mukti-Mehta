//SR-type latch:test bench
//Author: Mukti Mehta

module sr_latch_test;
reg s,r;
wire q,qbar;
sr_latch LAT(q,qbar,s,r);
initial
begin
$monitor($time,"s=%b,r=%b,q=%b,qbar=%b",s,r,q,qbar);
s=1'b0;r=1'b1;
#5 s=1'b1;r=1'b1;
#5 s=1'b1;r=1'b0;
#5 s=1'b1;r=1'b1;
#5 s=1'b0;r=1'b0;
#5 s=1'b1;r=1'b1;
end
endmodule

