//Author: Mukti Mehta
//Priority encoder: Test bench

module priority_encoder_test;
reg [7:0] in;
wire [2:0] code;
priority_encoder PEN(in,code);
initial
begin
$monitor($time,"in=%h,code=%h",in,code);
in=16'h0005;
#5 in=16'h0002;
#5 in=16'h0004;
#5 in=16'h0007;
#5 in=16'h0006;
#5 in=16'h0001;
#5 in=16'h0003;
#100 $finish;
end
endmodule
