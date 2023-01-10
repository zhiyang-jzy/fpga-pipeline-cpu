module xian(
    output [3:0]dig,
    output [7:0]seg,
    input [15:0]num,
    input clk
);

reg [15:0] tmp;
reg [6:0] cnt;

initial
begin

  tmp=num;
  cnt=0;

end

reg [6:0] ppos;
reg [6:0] nnum;

wire cclk;

always@(posedge cclk)
begin
    if(num==0)
    begin
      ppos<=3;
      nnum<=0;
    end
    else
    begin
      if(tmp==0)
      begin
        tmp<=num;
        cnt<=0;
      end
      else
      begin
        ppos<=3-cnt;
        nnum<=tmp%16;
        tmp<=tmp/16;
        cnt=cnt+1;
      end
    end

end

ditu dd(.clk(clk),.dig(dig),.seg(seg),.pos(ppos),.num(nnum));
div #(.N(10000)) dv(.clk(clk),.oclk(cclk));

always@(posedge clk)
begin

end

    
endmodule

module ditu (
    dig,
    seg,
    clk,
    pos,
    num

);

output  [3:0] dig;
output  [7:0] seg;
input  clk;
input [6:0] pos;
input [6:0] num;

reg [7:0] dt [15:0];

initial
begin
  dt[0] <=8'b11000000;
  dt[1] <=8'b11111001;
  dt[2] <=8'b10100100;
  dt[3] <=8'b10110000;
  dt[4] <=8'b10011001;
  dt[5] <=8'b10010010;
  dt[6] <=8'b10000010;
  dt[7] <=8'b11111000;
  dt[8] <=8'b10000000;
  dt[9] <=8'b10010000;
  dt[10]<=8'b10001000;
  dt[11]<=8'b10000011;
  dt[12]<=8'b11000110;
  dt[13]<=8'b10100001;
  dt[14]<=8'b10000110;
  dt[15]<=8'b10001110;

end

assign dig = ~((4'b0001)<<(pos));
assign seg = dt[num];

endmodule