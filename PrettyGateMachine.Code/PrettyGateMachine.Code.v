//--------------------------------------------------
// TERM PROJECT - ALU
//DUE - 11/16/18
//Cohort name: Pretty Gate Machine
//Members/netID: Paul Jacobo pdj170030
//               Patrick Meyomesse pgm170030
//               Alex Palm awp140130
//Software: Icarus Verilog
//Source: Cloned from Icarus/Verilog repository.
//          https://github.com/steveicarus/iverilog.git

//--------------------------------------------------


/* TO DO
8 muxes for output - acts as op code  selector and state Machine
 - indexed from m7, m6, m5, m4, m3, m2, m1, m0 from most significant to least sifnicant bit
 include in software discovery - logism

scale modules to 8 bits
*/


module logic_unit(output [7:0] result,  input [7:0]A, input [7:0] B, input [3:0]selector);

//this can be represented with 2 bits
//and
//or
//not
//xor

//result wires
  wire [7:0] andwire;
  wire [7:0] orwire;
  wire [7:0] notawire;
  wire [7:0] notbwire;
  wire [7:0] xorwire;

  reg nullin;

  and_unit andunit(andwire[7:0], A[7:0], B[7:0]);
  or_unit orunit(orwire[7:0], A[7:0], B[7:0]);
  notA_unit notaunit(notawire[7:0], A[7:0]);
  notB_unit notbunit(notbwire[7:0], B[7:0]);
  xor_unit xorunit(xorwire[7:0], A[7:0], B[7:0]);

  STtoMUX m0(result[0], selector[3:0], andwire[0], orwire[0], notawire[0], notbwire[0], xorwire[0], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m1(result[1], selector[3:0], andwire[1], orwire[1], notawire[1], notbwire[1], xorwire[1], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m2(result[2], selector[3:0], andwire[2], orwire[2], notawire[2], notbwire[2], xorwire[2], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m3(result[3], selector[3:0], andwire[3], orwire[3], notawire[3], notbwire[3], xorwire[3], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m4(result[4], selector[3:0], andwire[4], orwire[4], notawire[4], notbwire[4], xorwire[4], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m5(result[5], selector[3:0], andwire[5], orwire[5], notawire[5], notbwire[5], xorwire[5], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m6(result[6], selector[3:0], andwire[6], orwire[6], notawire[6], notbwire[6], xorwire[6], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);
  STtoMUX m7(result[7], selector[3:0], andwire[7], orwire[7], notawire[7], notbwire[7], xorwire[7], nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin, nullin);


endmodule

//8to1 mux
module STtoMUX(output result,
  input [3:0] s, input oneMUXinput,
  input twoMUXinput, input threeMUXinput,
  input fourMUXinput, input fiveMUXinput,
  input sixMUXinput, input sevenMUXinput,
  input eightMUXinput, input nineMUXinput,
  input tenMUXinput, input eleMUXinput,
  input twelMUXinput, input thirtMUXinput,
  input fourteenMUXinput, input fifteenMUXinput,
  input sixteenMUXinput);

  wire [3:0] notS;
  wire [15:0] andOUT;

  not(notS[0], s[0]);
  not(notS[1], s[1]);
  not(notS[2], s[2]);
  not(notS[3], s[3]);



  and(andOUT[0],  notS[0], notS[1], notS[2], notS[3], oneMUXinput);
  and(andOUT[1],  notS[0], notS[1], notS[2], s[3],    twoMUXinput);
  and(andOUT[2],  notS[0], notS[1], s[2],    notS[3], threeMUXinput);
  and(andOUT[3],  notS[0], notS[1], s[2],    s[3],    fourMUXinput);
  and(andOUT[4],  notS[0], s[1],    notS[2], notS[3], fiveMUXinput);
  and(andOUT[5],  notS[0], s[1],    notS[2], s[3],    sixMUXinput);
  and(andOUT[6],  notS[0], s[1],    s[2],    notS[3], sevenMUXinput);
  and(andOUT[7],  notS[0], s[1],    s[2],    s[3],    eightMUXinput);
  and(andOUT[8],  s[0],    notS[1], notS[2], notS[3], nineMUXinput);
  and(andOUT[9],  s[0],    notS[1], notS[2], s[3],    tenMUXinput);
  and(andOUT[10], s[0],    notS[1], s[2],    notS[3], elelMUXinput);
  and(andOUT[11], s[0],    notS[1], s[2],    s[3],    twelMUXinput);
  and(andOUT[12], s[0],    s[1],    notS[2], notS[3], thirtMUXinput);
  and(andOUT[13], s[0],    s[1],    notS[2], s[3],    fourteenMUXinput);
  and(andOUT[14], s[0],    s[1],    s[2],    notS[3], fifteenMUXinput);
  and(andOUT[15], s[0],    s[1],    s[2],    s[3],    sixteenMUXinput);



  or(result, andOUT[0], andOUT[1], andOUT[2], andOUT[3], andOUT[4], andOUT[5], andOUT[6], andOUT[7], andOUT[8],
     andOUT[9], andOUT[10], andOUT[11], andOUT[12], andOUT[13], andOUT[14], andOUT[15]);
endmodule

module and_unit(output [7:0] result, input[7:0] A, input [7:0] B);
  and a(result[0], A[0], B[0]);
  and b(result[1], A[1], B[1]);
  and c(result[2], A[2], B[2]);
  and c(result[3], A[3], B[3]);
  and d(result[4], A[4], B[4]);
  and e(result[5], A[5], B[5]);
  and f(result[6], A[6], B[6]);
  and g(result[7], A[7], B[7]);
endmodule

module or_unit(output [7:0] result, input[7:0] A, input [7:0] B);
  or a(result[0], A[0], B[0]);
  or b(result[1], A[1], B[1]);
  or c(result[2], A[2], B[2]);
  or d(result[3], A[3], B[3]);
  or e(result[4], A[4], B[4]);
  or f(result[5], A[5], B[5]);
  or g(result[6], A[6], B[6]);
  or h(result[7], A[7], B[7]);
endmodule

module notA_unit(output [7:0] result, input[7:0] A);
  not(result[0], A[0]);
  not(result[1], A[1]);
  not(result[2], A[2]);
  not(result[3], A[3]);
  not(result[4], A[4]);
  not(result[5], A[5]);
  not(result[6], A[6]);
  not(result[7], A[7]);
endmodule

module notB_unit(output [7:0] result, input [7:0] B);
  not(result[0], B[0]);
  not(result[1], B[1]);
  not(result[2], B[2]);
  not(result[3], B[3]);
  not(result[4], B[4]);
  not(result[5], B[5]);
  not(result[6], B[6]);
  not(result[7], B[7]);
endmodule

module xor_unit(output [7:0] result, input[7:0] A, input [7:0] B);
  xor(result[0], A[0], B[0]);
  xor(result[1], A[1], B[1]);
  xor(result[2], A[2], B[2]);
  xor(result[3], A[3], B[3]);
  xor(result[4], A[4], B[4]);
  xor(result[5], A[5], B[5]);
  xor(result[6], A[6], B[6]);
  xor(result[7], A[7], B[7]);
endmodule

module rightshifter(output [7:0] q, output [7:0] qn, input sh, input clk, input [7:0]A);

  wire notsh; //top
  not(notsh, sh);
  wire [6:0] a1out;
  wire [6:0] a2out;
  wire [6:0] orout;

  dff m7(q[7], qn[7], clk, A[7]);
  //indexing by significant digits
  and(a1out[6], q[7],sh ); //a1
  and(a2out[6], A[6], notsh);
  or(orout[6], a1out[6], a2out[6]);
  dff m6(q[6], qn[6], clk, orout[6]);

  and(a1out[5], q[6],sh);
  and(a2out[5], A[5], notsh);
  or(orout[5], a1out[5], a2out[5]);
  dff m5(q[5], qn[5], clk, orout[5]);

  and(a1out[4], q[5],sh);
  and(a2out[4], A[4], notsh);
  or(orout[4], a1out[4], a2out[4]);
  dff m4(q[4], qn[4], clk, orout[4]);

  and(a1out[3], q[4],sh);
  and(a2out[3], A[3], notsh);
  or(orout[3], a1out[3], a2out[3]);
  dff m3(q[3], qn[3], clk, orout[3]);

  and(a1out[2], q[3],sh);
  and(a2out[2], A[2], notsh);
  or(orout[2], a1out[2], a2out[2]);
  dff m2(q[2], qn[2], clk, orout[2]);

  and(a1out[1], q[2], sh);
  and(a2out[1],A[1], notsh );
  or(orout[1], a1out[1], a2out[1]);
  dff m1(q[1], qn[1], clk, orout[1]);

  and(a1out[0], q[1], sh );
  and(a2out[0],A[0], notsh );
  or(orout[0], a1out[0], a2out[0]);
  dff m0(q[0], qn[0], clk, orout[0]);


endmodule

module leftshifter(output [7:0] q, output [7:0] qn, input sh, input clk, input [7:0]A);

  wire notsh; //top
  not(notsh, sh);
  wire [6:0] a1out;
  wire [6:0] a2out;
  wire [6:0] orout;


  //indexing by significant digits
  and(a2out[6], A[7], notsh);
  and(a1out[6], q[6],sh ); //a1
  or(orout[6], a1out[6], a2out[6]);
  dff m7(q[7], qn[7], clk, orout[6]);

  and(a2out[5], A[6], notsh);
  and(a1out[5], q[5],sh ); //a1
  or(orout[5], a1out[5], a2out[5]);
  dff m6(q[6], qn[6], clk, orout[5]);

  and(a2out[4], A[5], notsh);
  and(a1out[4], q[3],sh ); //a1
  or(orout[4], a1out[4], a2out[4]);
  dff m5(q[5], qn[5], clk, orout[4]);

  and(a2out[3], A[4], notsh);
  and(a1out[3], q[3],sh ); //a1
  or(orout[3], a1out[3], a2out[3]);
  dff m4(q[4], qn[4], clk, orout[3]);

  and(a2out[2], A[3], notsh);
  and(a1out[2], q[2],sh ); //a1
  or(orout[2], a1out[2], a2out[2]);
  dff m3(q[3], qn[3], clk, orout[2]);

  and(a2out[1], A[2], notsh);
  and(a1out[1], q[1],sh ); //a1
  or(orout[1], a1out[1], a2out[1]);
  dff m2(q[2], qn[2], clk, orout[1]);

  and(a2out[0], A[1], notsh);
  and(a1out[0], q[0],sh ); //a1
  or(orout[0], a1out[0], a2out[0]);
  dff m1(q[1], qn[1], clk, orout[0]);

  dff m0(q[0], qn[0], clk, A[0]);

endmodule

//module leftshifter();
//endmodule

//edge triggered dff
module dff(output Q, output Qn, input C, input D);


   wire   Cn;   // Control input to the D latch.
   wire   Cnn;  // Control input to the SR latch.
   wire   DQ;   // Output from the D latch, input to the gated SR latch.
   wire   DQn;  // Output from the D latch, input to the gated SR latch.

   not(Cn, C);
   not(Cnn, Cn);
   d_latch dl(DQ, DQn, Cn, D);
   sr_latch_gated sr(Q, Qn, Cnn, DQ, DQn);
endmodule // d_flip_flop_edge_triggered

module d_latch(output Q, output Qn, input G,input D);

   wire   Dnotout;
   wire   Dandout;
   wire   Dandout2;

   not(Dnotout, D);
   and(Dandout, G, D);
   and(Dandout2, G, Dnotout);
   nor(Qn, Dandout, Q);
   nor(Q, Dandout2, Qn);
endmodule // d_latch

module sr_latch_gated(output Q, output Qn, input G, input S, input R);
   wire   S1;
   wire   R1;

   and(S1, G, S);
   and(R1, G, R);
   nor(Qn, S1, Q);
   nor(Q, R1, Qn);
endmodule // sr_latch_gated



module ALU(input [7:0] a, input[7:0] b, input [3:0] opcode, input m, input sh, input clk,  output [7:0] result , output carry);

  wire [7:0] eightbasuOUT;

  wire [7:0] AleftsOUT;
  wire [7:0] ArightsOUT;
  wire [7:0] AleftsOUTn;
  wire [7:0] ArightsOUTn;

  wire [7:0] BleftsOUT;
  wire [7:0] BrightsOUT;
  wire [7:0] BleftsOUTn;
  wire [7:0] BrightsOUTn;

  wire [7:0] aluLUOUT;

  reg nullin;


  /*
  module logic_unit(output [3:0] result,  input [3:0]A, input [3:0] B, input [2:0]selector);
  module rightshifter(output [7:0] q, output [7:0] qn, input sh, input clk, input [7:0]A);
  module leftshifter(output [7:0] q, output [7:0] qn, input sh, input clk, input [7:0]A);
  module fourB_asu(input [3:0] a, input [3:0] b, input M, output C, output [3:0] sum);

  */

  eightB_asu aluFBAU(a[7:0], b[7:0], m, carry, eightbasuOUT[7:0]);
  rightshifter AaluRS(ArightsOUT[7:0], ArightsOUTn[7:0], sh, clk, a[7:0] );
  leftshifter AaluLS(AleftsOUT[7:0], AleftsOUTn[7:0], sh, clk, a[7:0] );
  rightshifter BaluRS(BrightsOUT[7:0], BrightsOUTn[7:0], sh, clk, b[7:0] );
  leftshifter BaluLS(BleftsOUT[7:0], BleftsOUTn[7:0], sh, clk, b[7:0] );
  logic_unit aluLU(aluLUOUT[7:0],a[7:0], b[7:0], opcode[3:0]);



   //module STtoMUX(output result, input [2:0] s, input oneMUXinput, input twoMUXinput, input threeMUXinput, input fourMUXinput, input fiveMUXinput);
   // 5 aluLU inputs so opcode shares the same  code
   STtoMUX m7(result[7], opcode[3:0], aluLUOUT[7], aluLUOUT[7], aluLUOUT[7], aluLUOUT[7], aluLUOUT[7], eightbasuOUT[7], AleftsOUT[7], ArightsOUT[7], BleftsOUT[7], BrightsOUT[7], nullin,nullin,nullin,nullin,nullin,nullin ); //most significant bits
   STtoMUX m6(result[6], opcode[3:0], aluLUOUT[6], aluLUOUT[6], aluLUOUT[6], aluLUOUT[6], aluLUOUT[6], eightbasuOUT[6], AleftsOUT[6], ArightsOUT[6], BleftsOUT[6], BrightsOUT[6], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m5(result[5], opcode[3:0], aluLUOUT[5], aluLUOUT[5], aluLUOUT[5], aluLUOUT[5], aluLUOUT[5], eightbasuOUT[5], AleftsOUT[5], ArightsOUT[5], BleftsOUT[5], BrightsOUT[5], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m4(result[4], opcode[3:0], aluLUOUT[4], aluLUOUT[4], aluLUOUT[4], aluLUOUT[4], aluLUOUT[4], eightbasuOUT[4], AleftsOUT[4], ArightsOUT[4], BleftsOUT[4], BrightsOUT[4], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m3(result[3], opcode[3:0], aluLUOUT[3], aluLUOUT[3], aluLUOUT[3], aluLUOUT[3], aluLUOUT[3], eightbasuOUT[3], AleftsOUT[3], ArightsOUT[3], BleftsOUT[3], BrightsOUT[3], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m2(result[2], opcode[3:0], aluLUOUT[2], aluLUOUT[2], aluLUOUT[2], aluLUOUT[2], aluLUOUT[2], eightbasuOUT[2], AleftsOUT[2], ArightsOUT[2], BleftsOUT[2], BrightsOUT[2], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m1(result[1], opcode[3:0], aluLUOUT[1], aluLUOUT[1], aluLUOUT[1], aluLUOUT[1], aluLUOUT[1], eightbasuOUT[1], AleftsOUT[1], ArightsOUT[1], BleftsOUT[1], BrightsOUT[1], nullin,nullin,nullin,nullin,nullin,nullin );
   STtoMUX m0(result[0], opcode[3:0], aluLUOUT[0], aluLUOUT[0], aluLUOUT[0], aluLUOUT[0], aluLUOUT[0], eightbasuOUT[0], AleftsOUT[0], ArightsOUT[0], BleftsOUT[0], BrightsOUT[0], nullin,nullin,nullin,nullin,nullin,nullin );

   //  STtoMUX m0(result[0], selector[2:0], andwire[0], orwire[0], notawire[0], notbwire[0], xorwire[0]);



endmodule
//half adder - provided in the instructions
module Add_half (input a, b, output c_out, sum);
    xor G1(sum, a, b);
    and G2(c_out, a, b);
endmodule

//full adder - provided in the instructions
module Add_full (input a, b, c_in, output c_out, sum);
  wire w1, w2, w3;
  Add_half M1(a,b, w1, w2);
  Add_half M0(w2, c_in, w3, sum);
  or (c_out, w1, w3);
endmodule

//MODULE: 4-bit Unsigned Adder-Subtractor as diagramed in the instructions.
module eightB_asu(input [7:0] a, input [7:0] b, input M, output C, output [7:0] sum);

  /*
  Two sets of wires:
      w# set - carries output from xor gates to input into full adder
      c# set - carries output from full adders to input into the next full adder
  */


  wire [7:0] w;
  wire [6:0] c;


  /*
  Each 1/4 of the circuit is represented below by
  having an XOR gate and FULL Adder.
  Each XOR gate does not have input dependent of the output of the Full Adders.

  xor GATES(ouput, input1, input2);
      *output : - carried through wire (w#) to the input of a full Adder
      *input1&2 : - receives both from module parameters
                -1st input; a bit from  binary number B[#]
                -2nd input; the mode

  Add_full GATES(input1,input2,input3,output1,output2);
      *output : -1st output c#; carries output to input into next full adder until it eventually
                    outputs the carry (after last full adder)
                -2nd output sum[#]; sum of position's bit
      *input : -1st input w#; received from each full adder's neighboring xorgate
               -2nd input a[0]; bit from binary number A[#]
               -3rd input c#; recived from previous full adder's output

  */

  xor x0( w[0], b[0], M);
  Add_full FA0(w[0],a[0],M,c[0],sum[0]);

  xor x1( w[1], b[1], M);
  Add_full FA1(w[1],a[1],c[0],c[1],sum[1]);

  xor x2( w[2], b[2], M);
  Add_full FA2(w[2],a[2],c[1],c[2],sum[2]);

  xor x3( w[3], b[3], M);
  Add_full FA3(w[3],a[3],c[2],c[3],sum[3]);

  xor x4( w[4], b[4], M);
  Add_full FA4(w[4],a[0],c[3],c[4],sum[4]);

  xor x5( w[5], b[5], M);
  Add_full FA5(w[5],a[5],c[4],c[5],sum[5]);

  xor x6( w[6], b[6], M);
  Add_full FA6(w[6],a[6],c[5],c[6],sum[6]);

  xor x7( w[7], b[7], M);
  Add_full FA7(w[7],a[7],c[6], C,sum[7]);

endmodule

module testbench;
  wire [7:0] result;
  wire carry ; // error code
  reg [7:0] a;
  reg [7:0] b;
  reg M;
  reg [3:0] selector;
  reg clk;
  reg sh;
  /*
  module ALU(input [7:0] a,
  input[7:0] b, input [3:0] opcode,
  input m, input sh, input clk,
  output [7:0] result ,
  output carry);
  */

  initial begin
//module logic_unit(output [7:0] result,  input [7:0]A, input [7:0] B, input [3:0]selector);


  #0 $display("PERFORMING AND");
  #0 clk=0; M=0; sh=0;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("PERFORMING OR");
  #4999 a=0; b=0; selector =0;
  #5000 clk=0; M=0; sh=1;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("PERFORMING ~A");
  #4999 a=0; b=0; selector =0;
  #5000 clk=0; M=1; sh=0;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("PERFORMING ~B");
  #4999 a=0; b=0; selector =0;
  #5000 clk=0; M=1; sh=1;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("PERFORMING XOR");
  #4999 a=0; b=0; selector =0;
  #5000 clk=1; M=0; sh=0;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("PERFORMING OR");
  #4999 a=0; b=0; selector =0;
  #5000 clk=1; M=0; sh=1;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("SHIFTING LEFT");
  #4999 a=0; b=0; selector =0;
  #5000 clk=1; M=1; sh=0;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;

  #4999 $display("SHIFTING RIGHT");
  #4999 a=0; b=0; selector =0;
  #5000 clk=1; M=1; sh=1;
  for(selector=0; selector<16; selector=selector+1)
    for(a=0; a<16; a =a+1)
      for(b=0; b<16; b=b+1)
      #1;


  end
  //module logic_unit(output [7:0] result,  input [7:0]A, input [7:0] B, input [3:0]selector);
  logic_unit test(result[7:0], a[7:0], b[7:0], selector[3:0]);
  //ALU tb(a[7:0], b[7:0], selector[3:0], m, sh, clk, result[7:0], carry );
  //module ALU(input [7:0] a, input[7:0] b, input [3:0] opcode, input m, input sh, input clk,  output [7:0] result , output carry);


  always @ ( * ) begin
    $monitor("INPUT a=%b  INPUT b=%b RESULT=%b |||| M=%d sel=%b clk=%d sh=%d  carry =%d   time=%d", a,b,result,M,selector,clk,sh,carry,$time);
  end
endmodule
