//D-type latch:source code
// Author name:Mukti Mehta

module d_latch(d,q,en);
input d,en;
output q;
assign q=en?d:q;
endmodule
