//SR-type latch:source code
// Author name:Mukti Mehta

module sr_latch(q,qbar,s,r);
input s,r;
output q,qbar;
assign q = ~(r & qbar);
assign qbar = ~(s & q);
endmodule
