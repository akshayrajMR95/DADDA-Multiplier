`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.07.2024 10:09:24
// Design Name: 
// Module Name: dadda_16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dadda_16(
input [15:0] A,B, 
output wire [31:0] sum
    );
    
 // stage-1 sum and carry
 wire [11:0]s1,c1;
 wire  gen_pp [0:15][15:0];
    
// generating partial products 
genvar i,j;

for(i = 0; i<=15; i=i+1)begin
   for(j = 0; j<=15;j = j+1)begin
      assign gen_pp[i][j] = A[j]*B[i];
   end
end

//////////////////////////////////////////////////////////////stage1 16 ---> 13

half_adder HA0 (.a(gen_pp[13][0]),.b(gen_pp[12][1]),.sum(s1[0]), .carry(c1[0]));
half_adder HA1 (.a(gen_pp[11][3]),.b(gen_pp[10][4]),.sum(s1[2]), .carry(c1[2]));
half_adder HA2 (.a(gen_pp[9][6]),.b(gen_pp[8][7]),.sum(s1[5]), .carry(c1[5]));
half_adder HA3 (.a(gen_pp[10][6]),.b(gen_pp[9][7]),.sum(s1[8]), .carry(c1[8]));

 FA FA0(.a(gen_pp[14][0]), .b(gen_pp[13][1]), .cin(gen_pp[12][2]), .sum(s1[1]), .cout(c1[1]));
 FA FA1(.a(gen_pp[15][0]), .b(gen_pp[14][1]), .cin(gen_pp[13][2]), .sum(s1[3]), .cout(c1[3]));
 FA FA2(.a(gen_pp[12][3]), .b(gen_pp[11][4]), .cin(gen_pp[10][5]), .sum(s1[4]), .cout(c1[4]));
 FA FA3(.a(gen_pp[1][15]), .b(gen_pp[15][1]), .cin(gen_pp[14][2]), .sum(s1[6]), .cout(c1[6]));
 FA FA4(.a(gen_pp[13][3]), .b(gen_pp[12][4]), .cin(gen_pp[11][5]), .sum(s1[7]), .cout(c1[7]));
 FA FA5(.a(gen_pp[3][14]), .b(gen_pp[2][15]), .cin(gen_pp[15][2]), .sum(s1[9]), .cout(c1[9]));
 FA FA6(.a(gen_pp[14][3]), .b(gen_pp[13][4]), .cin(gen_pp[12][5]), .sum(s1[10]), .cout(c1[10]));
 FA FA7(.a(gen_pp[5][13]), .b(gen_pp[4][14]), .cin(gen_pp[3][15]), .sum(s1[11]), .cout(c1[11]));


///////////////////////////////////////////////////////////stage 2 13 ---> 9


wire [43:0]s2,c2;

half_adder HA4 (.a(gen_pp[9][0]),.b(gen_pp[8][1]),.sum(s2[0]), .carry(c2[0]));
half_adder HA5 (.a(gen_pp[7][3]),.b(gen_pp[6][4]),.sum(s2[2]), .carry(c2[2]));
half_adder HA6 (.a(gen_pp[5][6]),.b(gen_pp[4][7]),.sum(s2[5]), .carry(c2[5]));
half_adder HA7 (.a(gen_pp[3][9]),.b(gen_pp[2][10]),.sum(s2[9]), .carry(c2[9]));


 FA FA8(.a(gen_pp[10][0]), .b(gen_pp[9][1]), .cin(gen_pp[8][2]), .sum(s2[1]), .cout(c2[1]));
 FA FA9(.a(gen_pp[11][0]), .b(gen_pp[10][1]), .cin(gen_pp[9][2]), .sum(s2[3]), .cout(c2[3]));
 FA FA10(.a(gen_pp[8][3]), .b(gen_pp[7][4]), .cin(gen_pp[6][5]), .sum(s2[4]), .cout(c2[4]));
 FA FA11(.a(gen_pp[12][0]), .b(gen_pp[11][1]), .cin(gen_pp[10][2]), .sum(s2[6]), .cout(c2[6]));
 FA FA12(.a(gen_pp[9][3]), .b(gen_pp[8][4]), .cin(gen_pp[7][5]), .sum(s2[7]), .cout(c2[7]));
 FA FA13(.a(gen_pp[6][6]), .b(gen_pp[5][7]), .cin(gen_pp[4][8]), .sum(s2[8]), .cout(c2[8]));
 FA FA14(.a(s1[0]), .b(gen_pp[11][2]), .cin(gen_pp[10][3]), .sum(s2[10]), .cout(c2[10]));
 FA FA15(.a(gen_pp[9][4]), .b(gen_pp[8][5]), .cin(gen_pp[7][6]), .sum(s2[11]), .cout(c2[11]));
 FA FA16(.a(gen_pp[6][7]), .b(gen_pp[5][8]), .cin(gen_pp[4][9]), .sum(s2[12]), .cout(c2[12]));
 FA FA17(.a(gen_pp[3][10]), .b(gen_pp[2][11]), .cin(gen_pp[1][12]), .sum(s2[13]), .cout(c2[13]));
 FA FA18(.a(s1[1]), .b(s1[2]), .cin(gen_pp[9][5]), .sum(s2[14]), .cout(c2[14]));
 FA FA19(.a(gen_pp[8][6]), .b(gen_pp[7][7]), .cin(gen_pp[6][8]), .sum(s2[15]), .cout(c2[15]));
 FA FA20(.a(gen_pp[5][9]), .b(gen_pp[4][10]), .cin(gen_pp[3][11]), .sum(s2[16]), .cout(c2[16]));
 FA FA21(.a(gen_pp[2][12]), .b(gen_pp[1][13]), .cin(gen_pp[0][14]), .sum(s2[17]), .cout(c2[17]));
 FA FA22(.a(s1[3]), .b(s1[4]), .cin(s1[5]), .sum(s2[18]), .cout(c2[18]));
 FA FA23(.a(gen_pp[7][8]), .b(gen_pp[6][9]), .cin(gen_pp[5][10]), .sum(s2[19]), .cout(c2[19]));
 FA FA24(.a(gen_pp[4][11]), .b(gen_pp[3][12]), .cin(gen_pp[2][13]), .sum(s2[20]), .cout(c2[20]));
 FA FA25(.a(gen_pp[1][14]), .b(gen_pp[0][15]), .cin(c1[1]), .sum(s2[21]), .cout(c2[21]));
 FA FA26(.a(s1[6]), .b(s1[7]), .cin(s1[8]), .sum(s2[22]), .cout(c2[22]));
 FA FA27(.a(gen_pp[8][8]), .b(gen_pp[7][9]), .cin(gen_pp[6][10]), .sum(s2[23]), .cout(c2[23]));
 
 
 
 FA FA28(.a(gen_pp[5][11]), .b(gen_pp[4][12]), .cin(gen_pp[3][13]), .sum(s2[24]), .cout(c2[24]));
 FA FA29(.a(gen_pp[2][14]), .b(c1[3]), .cin(c1[4]), .sum(s2[25]), .cout(c2[25]));
 FA FA30(.a(s1[9]), .b(s1[10]), .cin(gen_pp[11][6]), .sum(s2[26]), .cout(c2[26]));
 FA FA31(.a(gen_pp[10][7]), .b(gen_pp[9][8]), .cin(gen_pp[8][9]), .sum(s2[27]), .cout(c2[27]));
 FA FA32(.a(gen_pp[7][10]), .b(gen_pp[6][11]), .cin(gen_pp[5][12]), .sum(s2[28]), .cout(c2[28]));
 FA FA33(.a(gen_pp[4][13]), .b(c1[6]), .cin(c1[7]), .sum(s2[29]), .cout(c2[29])); 
 FA FA34(.a(s1[11]), .b(gen_pp[15][3]), .cin(gen_pp[14][4]), .sum(s2[30]), .cout(c2[30]));
 FA FA35(.a(gen_pp[13][5]), .b(gen_pp[12][6]), .cin(gen_pp[11][7]), .sum(s2[31]), .cout(c2[31]));
 FA FA36(.a(gen_pp[10][8]), .b(gen_pp[9][9]), .cin(gen_pp[8][10]), .sum(s2[32]), .cout(c2[32]));
 FA FA37(.a(gen_pp[7][11]), .b(gen_pp[6][12]), .cin(c1[9]), .sum(s2[33]), .cout(c2[33])); 
 FA FA38(.a(gen_pp[7][12]), .b(gen_pp[6][13]), .cin(gen_pp[5][14]), .sum(s2[34]), .cout(c2[34]));
 FA FA39(.a(gen_pp[4][15]), .b(gen_pp[15][4]), .cin(gen_pp[14][5]), .sum(s2[35]), .cout(c2[35]));
 FA FA40(.a(gen_pp[13][6]), .b(gen_pp[12][7]), .cin(gen_pp[11][8]), .sum(s2[36]), .cout(c2[36]));
 FA FA41(.a(gen_pp[10][9]), .b(gen_pp[9][10]), .cin(gen_pp[8][11]), .sum(s2[37]), .cout(c2[37]));
 FA FA42(.a(gen_pp[9][11]), .b(gen_pp[8][12]), .cin(gen_pp[7][13]), .sum(s2[38]), .cout(c2[38]));
 FA FA43(.a(gen_pp[6][14]), .b(gen_pp[5][15]), .cin(gen_pp[15][5]), .sum(s2[39]), .cout(c2[39]));
 FA FA44(.a(gen_pp[14][6]), .b(gen_pp[13][7]), .cin(gen_pp[12][8]), .sum(s2[40]), .cout(c2[40]));
 FA FA45(.a(gen_pp[11][10]), .b(gen_pp[10][11]), .cin(gen_pp[9][12]), .sum(s2[41]), .cout(c2[41]));
 FA FA46(.a(gen_pp[8][13]), .b(gen_pp[7][14]), .cin(gen_pp[6][15]), .sum(s2[42]), .cout(c2[42]));
 FA FA47(.a(gen_pp[13][9]), .b(gen_pp[12][10]), .cin(gen_pp[11][1]), .sum(s2[43]), .cout(c2[43]));

 
 
///////////////////////////////////////////stage_3 13 ---> 9

wire [53:0] s3,c3;

half_adder HA48 (.a(gen_pp[6][0]),.b(gen_pp[5][1]),.sum(s3[0]), .carry(c3[0]));
half_adder HA49 (.a(gen_pp[4][3]),.b(gen_pp[3][4]),.sum(s3[2]), .carry(c3[2]));
half_adder HA50 (.a(gen_pp[2][6]),.b(gen_pp[1][7]),.sum(s3[5]), .carry(c3[5]));


FA FA51(.a(gen_pp[7][0]), .b(gen_pp[6][1]), .cin(gen_pp[5][2]), .sum(s3[1]), .cout(c3[1]));
FA FA52(.a(gen_pp[8][0]), .b(gen_pp[7][1]), .cin(gen_pp[6][2]), .sum(s3[3]), .cout(c3[3]));
FA FA53(.a(gen_pp[5][3]), .b(gen_pp[4][4]), .cin(gen_pp[3][5]), .sum(s3[4]), .cout(c3[4]));
FA FA54(.a(s2[0]), .b(gen_pp[7][2]), .cin(gen_pp[6][3]), .sum(s3[6]), .cout(c3[6]));
FA FA55(.a(gen_pp[5][4]), .b(gen_pp[4][5]), .cin(gen_pp[3][6]), .sum(s3[7]), .cout(c3[7]));
FA FA56(.a(gen_pp[2][7]), .b(gen_pp[1][8]), .cin(gen_pp[0][9]), .sum(s3[8]), .cout(c3[8]));
FA FA57(.a(s2[1]), .b(s2[2]), .cin(gen_pp[5][5]), .sum(s3[9]), .cout(c3[9]));
FA FA58(.a(gen_pp[4][6]), .b(gen_pp[3][7]), .cin(gen_pp[2][8]), .sum(s3[10]), .cout(c3[10]));
FA FA59(.a(gen_pp[1][9]), .b(gen_pp[0][10]), .cin(c2[0]), .sum(s3[11]), .cout(c3[11]));
FA FA60(.a(s2[3]), .b(s2[4]), .cin(s2[5]), .sum(s3[12]), .cout(c3[12]));
FA FA61(.a(gen_pp[3][8]), .b(gen_pp[2][9]), .cin(gen_pp[1][10]), .sum(s3[13]), .cout(c3[13]));
FA FA62(.a(gen_pp[0][11]), .b(c2[1]), .cin(c2[2]), .sum(s3[14]), .cout(c3[14]));
FA FA63(.a(s2[6]), .b(s2[7]), .cin(s2[8]), .sum(s3[15]), .cout(c3[15]));
FA FA64(.a(s2[9]), .b(gen_pp[1][11]), .cin(gen_pp[0][12]), .sum(s3[16]), .cout(c3[16]));
FA FA65(.a(c2[3]), .b(c2[4]), .cin(c2[5]), .sum(s3[17]), .cout(c3[17]));
FA FA66(.a(s2[10]), .b(s2[11]), .cin(s2[12]), .sum(s3[18]), .cout(c3[18]));
FA FA67(.a(s2[13]), .b(gen_pp[0][13]), .cin(c2[6]), .sum(s3[19]), .cout(c3[19]));
FA FA68(.a(c2[7]), .b(c2[8]), .cin(c2[9]), .sum(s3[20]), .cout(c3[20]));
FA FA69(.a(s2[14]), .b(s2[15]), .cin(s2[16]), .sum(s3[21]), .cout(c3[21]));
FA FA70(.a(s2[17]), .b(c1[0]), .cin(c2[10]), .sum(s3[22]), .cout(c3[22]));



FA FA71(.a(c2[11]), .b(c2[12]), .cin(c2[13]), .sum(s3[23]), .cout(c3[23]));
FA FA72(.a(s2[18]), .b(s2[19]), .cin(s2[20]), .sum(s3[24]), .cout(c3[24]));
FA FA73(.a(s2[21]), .b(c1[2]), .cin(c2[14]), .sum(s3[25]), .cout(c3[25]));
FA FA74(.a(c2[15]), .b(c2[16]), .cin(c2[17]), .sum(s3[26]), .cout(c3[26]));
FA FA75(.a(s2[22]), .b(s2[23]), .cin(s2[24]), .sum(s3[27]), .cout(c3[27]));
FA FA76(.a(s2[25]), .b(c1[5]), .cin(c2[18]), .sum(s3[28]), .cout(c3[28]));
FA FA77(.a(c2[19]), .b(c2[20]), .cin(c2[21]), .sum(s3[29]), .cout(c3[29]));
FA FA78(.a(s2[26]), .b(s2[27]), .cin(s2[28]), .sum(s3[30]), .cout(c3[30]));
FA FA79(.a(s2[29]), .b(c1[8]), .cin(c2[22]), .sum(s3[31]), .cout(c3[31]));
FA FA80(.a(c2[23]), .b(c2[24]), .cin(c2[25]), .sum(s3[32]), .cout(c3[32]));
FA FA81(.a(s2[30]), .b(s2[31]), .cin(s2[32]), .sum(s3[33]), .cout(c3[33]));
FA FA82(.a(s2[33]), .b(c1[10]), .cin(c2[26]), .sum(s3[34]), .cout(c3[34]));
FA FA83(.a(c2[27]), .b(c2[28]), .cin(c2[29]), .sum(s3[35]), .cout(c3[35]));




FA FA84(.a(s2[34]), .b(s2[35]), .cin(s2[36]), .sum(s3[36]), .cout(c3[36]));
FA FA85(.a(s2[37]), .b(c1[11]), .cin(c2[30]), .sum(s3[37]), .cout(c3[37]));
FA FA86(.a(c2[31]), .b(c2[32]), .cin(c2[33]), .sum(s3[38]), .cout(c3[38]));
FA FA87(.a(s2[38]), .b(s2[39]), .cin(s2[40]), .sum(s3[39]), .cout(c3[39]));
FA FA88(.a(gen_pp[11][9]), .b(gen_pp[10][10]), .cin(c2[34]), .sum(s3[40]), .cout(c3[40]));
FA FA89(.a(c2[35]), .b(c2[36]), .cin(c2[37]), .sum(s3[41]), .cout(c3[41]));
FA FA90(.a(s2[41]), .b(s2[42]), .cin(gen_pp[15][6]), .sum(s3[42]), .cout(c3[42]));
FA FA91(.a(gen_pp[14][7]), .b(gen_pp[13][8]), .cin(gen_pp[12][9]), .sum(s3[43]), .cout(c3[43]));
FA FA92(.a(c2[38]), .b(c2[39]), .cin(c2[40]), .sum(s3[44]), .cout(c3[44]));
FA FA93(.a(s2[43]), .b(gen_pp[10][112]), .cin(gen_pp[9][13]), .sum(s3[45]), .cout(c3[45]));
FA FA94(.a(gen_pp[8][14]), .b(gen_pp[7][15]), .cin(gen_pp[15][7]), .sum(s3[46]), .cout(c3[46]));
FA FA95(.a(gen_pp[14][8]), .b(c2[41]), .cin(c2[42]), .sum(s3[47]), .cout(c3[47]));
FA FA96(.a(gen_pp[15][8]), .b(gen_pp[14][9]), .cin(gen_pp[13][10]), .sum(s3[48]), .cout(c3[48]));
FA FA97(.a(gen_pp[12][11]), .b(gen_pp[11][12]), .cin(gen_pp[10][13]), .sum(s3[49]), .cout(c3[49]));
FA FA98(.a(gen_pp[9][14]), .b(gen_pp[8][15]), .cin(c2[43]), .sum(s3[50]), .cout(c3[50]));
FA FA99(.a(gen_pp[9][15]), .b(gen_pp[10][14]), .cin(gen_pp[11][13]), .sum(s3[51]), .cout(c3[51]));
FA FA100(.a(gen_pp[12][12]), .b(gen_pp[13][11]), .cin(gen_pp[14][10]), .sum(s3[52]), .cout(c3[52]));
FA FA101(.a(gen_pp[10][15]), .b(gen_pp[11][14]), .cin(gen_pp[12][13]), .sum(s3[53]), .cout(c3[53]));



/////////////////////////////// stage 4 6 ---> 4


wire [45:0] s4,c4;

half_adder HA102 (.a(gen_pp[4][0]),.b(gen_pp[3][1]),.sum(s4[0]), .carry(c4[0]));
half_adder HA103 (.a(gen_pp[2][3]),.b(gen_pp[1][4]),.sum(s4[2]), .carry(c4[2]));


FA FA104(.a(gen_pp[5][0]), .b(gen_pp[4][1]), .cin(gen_pp[3][2]), .sum(s4[1]), .cout(c4[1]));
FA FA105(.a(s3[0]), .b(gen_pp[4][2]), .cin(gen_pp[3][3]), .sum(s4[3]), .cout(c4[3]));
FA FA106(.a(gen_pp[2][4]), .b(gen_pp[1][5]), .cin(gen_pp[0][6]), .sum(s4[4]), .cout(c4[4]));
FA FA107(.a(s3[1]), .b(s3[2]), .cin(gen_pp[2][5]), .sum(s4[5]), .cout(c4[5]));
FA FA108(.a(gen_pp[1][6]), .b(gen_pp[0][7]), .cin(c3[0]), .sum(s4[6]), .cout(c4[6]));
FA FA7109(.a(s3[3]), .b(s3[4]), .cin(s3[5]), .sum(s4[7]), .cout(c4[7]));
FA FA110(.a(gen_pp[0][8]), .b(c3[1]), .cin(c3[2]), .sum(s4[8]), .cout(c4[8]));
FA FA111(.a(s3[6]), .b(s3[7]), .cin(s3[8]), .sum(s4[9]), .cout(c4[9]));
FA FA112(.a(c3[3]), .b(c3[4]), .cin(c3[5]), .sum(s4[10]), .cout(c4[10]));
FA FA113(.a(s3[9]), .b(s3[10]), .cin(s3[11]), .sum(s4[11]), .cout(c4[11]));
FA FA114(.a(c3[6]), .b(c3[7]), .cin(c3[8]), .sum(s4[12]), .cout(c4[12]));
FA FA115(.a(s3[12]), .b(s3[13]), .cin(s3[14]), .sum(s4[13]), .cout(c4[13]));
FA FA116(.a(c3[9]), .b(c3[10]), .cin(c3[11]), .sum(s4[14]), .cout(c4[14]));


FA FA117(.a(s3[15]), .b(s3[16]), .cin(s3[17]), .sum(s4[15]), .cout(c4[15]));
FA FA118(.a(c3[12]), .b(c3[13]), .cin(c3[14]), .sum(s4[16]), .cout(c4[16]));
FA FA119(.a(s3[18]), .b(s3[19]), .cin(s3[20]), .sum(s4[17]), .cout(c4[17]));
FA FA120(.a(c3[15]), .b(c3[16]), .cin(c3[17]), .sum(s4[18]), .cout(c4[18]));
FA FA121(.a(s3[21]), .b(s3[22]), .cin(s3[23]), .sum(s4[19]), .cout(c4[19]));
FA FA122(.a(c3[18]), .b(c3[19]), .cin(c3[20]), .sum(s4[20]), .cout(c4[20]));
FA FA123(.a(s3[24]), .b(s3[25]), .cin(s3[26]), .sum(s4[21]), .cout(c4[21]));
FA FA124(.a(c3[21]), .b(c3[22]), .cin(c3[23]), .sum(s4[22]), .cout(c4[22]));
FA FA125(.a(s3[27]), .b(s3[28]), .cin(s3[29]), .sum(s4[23]), .cout(c4[23]));
FA FA126(.a(c3[24]), .b(c3[25]), .cin(c3[26]), .sum(s4[24]), .cout(c4[24]));
FA FA127(.a(s3[30]), .b(s3[31]), .cin(s3[32]), .sum(s4[25]), .cout(c4[25]));
FA FA128(.a(c3[27]), .b(c3[28]), .cin(c3[29]), .sum(s4[26]), .cout(c4[26]));
FA FA129(.a(s3[33]), .b(s3[34]), .cin(s3[35]), .sum(s4[27]), .cout(c4[27]));
FA FA130(.a(c3[30]), .b(c3[31]), .cin(c3[32]), .sum(s4[28]), .cout(c4[28]));
FA FA131(.a(s3[36]), .b(s3[37]), .cin(s3[38]), .sum(s4[29]), .cout(c4[29]));
FA FA132(.a(c3[33]), .b(c3[34]), .cin(c3[35]), .sum(s4[30]), .cout(c4[30]));
FA FA133(.a(s3[39]), .b(s3[40]), .cin(s3[41]), .sum(s4[31]), .cout(c4[31]));
FA FA134(.a(c3[36]), .b(c3[37]), .cin(c3[38]), .sum(s4[32]), .cout(c4[32]));

FA FA135(.a(s3[42]), .b(s3[43]), .cin(s3[44]), .sum(s4[33]), .cout(c4[33]));
FA FA136(.a(c3[39]), .b(c3[40]), .cin(c3[41]), .sum(s4[34]), .cout(c4[34]));
FA FA137(.a(s3[45]), .b(s3[46]), .cin(s3[47]), .sum(s4[35]), .cout(c4[35]));
FA FA138(.a(c3[42]), .b(c3[43]), .cin(c3[44]), .sum(s4[36]), .cout(c4[36]));
FA FA139(.a(s3[48]), .b(s3[49]), .cin(s3[50]), .sum(s4[37]), .cout(c4[37]));
FA FA140(.a(c3[45]), .b(c3[46]), .cin(c3[47]), .sum(s4[38]), .cout(c4[38]));
FA FA141(.a(s3[51]), .b(s3[52]), .cin(gen_pp[15][9]), .sum(s4[39]), .cout(c4[39]));
FA FA142(.a(c3[48]), .b(c3[49]), .cin(c3[50]), .sum(s4[40]), .cout(c4[40]));
FA FA143(.a(s3[53]), .b(gen_pp[13][12]), .cin(gen_pp[14][11]), .sum(s4[41]), .cout(c4[41]));
FA FA145(.a(gen_pp[15][10]), .b(c3[51]), .cin(c3[52]), .sum(s4[42]), .cout(c4[42]));
FA FA146(.a(gen_pp[11][5]), .b(gen_pp[12][14]), .cin(gen_pp[13][3]), .sum(s4[43]), .cout(c4[43]));
FA FA147(.a(gen_pp[14][12]), .b(gen_pp[15][11]), .cin(c3[53]), .sum(s4[44]), .cout(c4[44]));
FA FA148(.a(gen_pp[12][15]), .b(gen_pp[13][14]), .cin(gen_pp[14][13]), .sum(s4[45]), .cout(c4[45]));



/////////////////////////////// stage 5 4 ---> 3

wire [25:0] s5,c5;

half_adder HA149 (.a(gen_pp[3][0]),.b(gen_pp[2][1]),.sum(s5[0]), .carry(c5[0]));

FA FA150(.a(s4[0]), .b(gen_pp[2][2]), .cin(gen_pp[1][3]), .sum(s5[1]), .cout(c5[1]));
FA FA151(.a(s4[1]), .b(s4[2]), .cin(gen_pp[0][5]), .sum(s5[2]), .cout(c5[2]));
FA FA152(.a(s4[3]), .b(s4[4]), .cin(c4[1]), .sum(s5[3]), .cout(c5[3]));
FA FA153(.a(s4[5]), .b(s4[6]), .cin(c4[3]), .sum(s5[4]), .cout(c5[4]));
FA FA154(.a(s4[7]), .b(s4[8]), .cin(c4[5]), .sum(s5[5]), .cout(c5[5]));
FA FA155(.a(s4[9]), .b(s4[10]), .cin(c4[7]), .sum(s5[6]), .cout(c5[6]));
FA FA156(.a(s4[11]), .b(s4[12]), .cin(c4[9]), .sum(s5[7]), .cout(c5[7]));
FA FA157(.a(s4[13]), .b(s4[14]), .cin(c4[11]), .sum(s5[8]), .cout(c5[8]));
FA FA158(.a(s4[15]), .b(s4[16]), .cin(c4[13]), .sum(s5[9]), .cout(c5[9]));
FA FA159(.a(s4[17]), .b(s4[18]), .cin(c4[15]), .sum(s5[10]), .cout(c5[10]));
FA FA160(.a(s4[19]), .b(s4[20]), .cin(c4[17]), .sum(s5[11]), .cout(c5[11]));
FA FA161(.a(s4[21]), .b(s4[22]), .cin(c4[19]), .sum(s5[12]), .cout(c5[12]));
FA FA162(.a(s4[23]), .b(s4[24]), .cin(c4[21]), .sum(s5[13]), .cout(c5[13]));
FA FA163(.a(s4[25]), .b(s4[26]), .cin(c4[23]), .sum(s5[14]), .cout(c5[14]));
FA FA164(.a(s4[27]), .b(s4[28]), .cin(c4[25]), .sum(s5[15]), .cout(c5[15]));
FA FA165(.a(s4[29]), .b(s4[30]), .cin(c4[27]), .sum(s5[16]), .cout(c5[16]));
FA FA166(.a(s4[31]), .b(s4[32]), .cin(c4[29]), .sum(s5[17]), .cout(c5[17]));

FA FA167(.a(s4[33]), .b(s4[34]), .cin(c4[31]), .sum(s5[18]), .cout(c5[18]));
FA FA168(.a(s4[35]), .b(s4[36]), .cin(c4[33]), .sum(s5[19]), .cout(c5[19]));
FA FA169(.a(s4[37]), .b(s4[38]), .cin(c4[35]), .sum(s5[20]), .cout(c5[20]));
FA FA170(.a(s4[39]), .b(s4[40]), .cin(c4[37]), .sum(s5[21]), .cout(c5[21]));
FA FA171(.a(s4[41]), .b(s4[42]), .cin(c4[39]), .sum(s5[22]), .cout(c5[22]));
FA FA172(.a(s4[43]), .b(s4[44]), .cin(c4[41]), .sum(s5[23]), .cout(c5[23]));
FA FA173(.a(s4[45]), .b(gen_pp[15][12]), .cin(c4[43]), .sum(s5[24]), .cout(c5[24]));
FA FA174(.a(gen_pp[13][15]), .b(gen_pp[14][14]), .cin(gen_pp[15][13]), .sum(s5[25]), .cout(c5[25]));



/////////////////////////////// stage 5 3 ---> 2

wire [28:0] s6,c6;

assign s6[0]=0;
assign c6[0]=0;
half_adder HAA176(.a(gen_pp[2][0]), .b(gen_pp[1][1]), .sum(s6[1]), .carry(c6[1]));

FA FA177(.a(s5[0]), .b(gen_pp[1][2]), .cin(gen_pp[0][3]), .sum(s6[2]), .cout(c6[2]));
FA FA178(.a(s5[1]), .b(gen_pp[0][4]), .cin(c5[0]), .sum(s6[3]), .cout(c6[3]));
FA FA179(.a(s5[2]), .b(c4[0]), .cin(c5[1]), .sum(s6[4]), .cout(c6[4]));
FA FA180(.a(s5[3]), .b(c4[2]), .cin(c5[2]), .sum(s6[5]), .cout(c6[5]));
FA FA181(.a(s5[4]), .b(c4[4]), .cin(c5[3]), .sum(s6[6]), .cout(c6[6]));
FA FA182(.a(s5[5]), .b(c4[6]), .cin(c5[4]), .sum(s6[7]), .cout(c6[7]));
FA FA183(.a(s5[6]), .b(c4[8]), .cin(c5[5]), .sum(s6[8]), .cout(c6[8]));
FA FA184(.a(s5[7]), .b(c4[10]), .cin(c5[6]), .sum(s6[9]), .cout(c6[9]));
FA FA185(.a(s5[8]), .b(c4[12]), .cin(c5[7]), .sum(s6[10]), .cout(c6[10]));
FA FA186(.a(s5[9]), .b(c4[14]), .cin(c5[8]), .sum(s6[11]), .cout(c6[11]));
FA FA187(.a(s5[10]), .b(c4[16]), .cin(c5[9]), .sum(s6[12]), .cout(c6[12]));
FA FA188(.a(s5[11]), .b(c4[18]), .cin(c5[10]), .sum(s6[13]), .cout(c6[13]));
FA FA189(.a(s5[12]), .b(c4[20]), .cin(c5[11]), .sum(s6[14]), .cout(c6[14]));
FA FA190(.a(s5[13]), .b(c4[22]), .cin(c5[12]), .sum(s6[15]), .cout(c6[15]));
FA FA191(.a(s5[14]), .b(c4[24]), .cin(c5[13]), .sum(s6[16]), .cout(c6[16]));
FA FA192(.a(s5[15]), .b(c4[26]), .cin(c5[14]), .sum(s6[17]), .cout(c6[17]));
FA FA193(.a(s5[16]), .b(c4[28]), .cin(c5[15]), .sum(s6[18]), .cout(c6[18]));
FA FA194(.a(s5[17]), .b(c4[30]), .cin(c5[16]), .sum(s6[19]), .cout(c6[19]));
FA FA195(.a(s5[18]), .b(c4[32]), .cin(c5[17]), .sum(s6[20]), .cout(c6[20]));
FA FA196(.a(s5[19]), .b(c4[34]), .cin(c5[18]), .sum(s6[21]), .cout(c6[21]));
FA FA197(.a(s5[20]), .b(c4[36]), .cin(c5[19]), .sum(s6[22]), .cout(c6[22]));
FA FA198(.a(s5[21]), .b(c4[38]), .cin(c5[20]), .sum(s6[23]), .cout(c6[23]));
FA FA199(.a(s5[22]), .b(c4[40]), .cin(c5[21]), .sum(s6[24]), .cout(c6[24]));
FA FA200(.a(s5[23]), .b(c4[42]), .cin(c5[22]), .sum(s6[25]), .cout(c6[25]));
FA FA201(.a(s5[24]), .b(c4[44]), .cin(c5[23]), .sum(s6[26]), .cout(c6[26]));
FA FA202(.a(s5[25]), .b(c4[45]), .cin(c5[24]), .sum(s6[27]), .cout(c6[27]));
FA FA203(.a(gen_pp[14][15]), .b(gen_pp[15][14]), .cin(c5[25]), .sum(s6[28]), .cout(c6[28]));



//wire [29:0] temp_A,temp_B;
//wire cin_0 = 0;
//wire cout_0;
//wire [29:0] sum_temp;
//assign temp_A[29:0] = {gen_pp[15][15],s6,gen_pp[1][0]};
//assign temp_B[29:0] = {c6,gen_pp[0][2],gen_pp[0][1]};
//cla cla_0(.A(temp_A), .B(temp_B),.cin(cin_0),.Sum(sum_temp),.cout(cout_0));
//assign sum = {cout_0, sum_temp,gen_pp[0][0]};


/////////////////////////////////////final stage 2 ---> 1
wire [29:0] c7;

half_adder HAA204(.a(gen_pp[1][0]), .b(gen_pp[0][1]), .sum(sum[1]), .carry(c7[0]));

FA FA205(.a(s6[1]), .b(gen_pp[0][2]), .cin(c7[0]), .sum(sum[2]), .cout(c7[1]));
FA FA206(.a(s6[2]), .b(c6[1]), .cin(c7[1]), .sum(sum[3]), .cout(c7[2]));
FA FA207(.a(s6[3]), .b(c6[2]), .cin(c7[2]), .sum(sum[4]), .cout(c7[3]));
FA FA208(.a(s6[4]), .b(c6[3]), .cin(c7[3]), .sum(sum[5]), .cout(c7[4]));
FA FA209(.a(s6[5]), .b(c6[4]), .cin(c7[4]), .sum(sum[6]), .cout(c7[5]));
FA FA210(.a(s6[6]), .b(c6[5]), .cin(c7[5]), .sum(sum[7]), .cout(c7[6]));
FA FA211(.a(s6[7]), .b(c6[6]), .cin(c7[6]), .sum(sum[8]), .cout(c7[7]));
FA FA212(.a(s6[8]), .b(c6[7]), .cin(c7[7]), .sum(sum[9]), .cout(c7[8]));
FA FA213(.a(s6[9]), .b(c6[8]), .cin(c7[8]), .sum(sum[10]), .cout(c7[9]));
FA FA214(.a(s6[10]), .b(c6[9]), .cin(c7[9]), .sum(sum[11]), .cout(c7[10]));
FA FA215(.a(s6[11]), .b(c6[10]), .cin(c7[10]), .sum(sum[12]), .cout(c7[11]));
FA FA216(.a(s6[12]), .b(c6[11]), .cin(c7[11]), .sum(sum[13]), .cout(c7[12]));
FA FA217(.a(s6[13]), .b(c6[12]), .cin(c7[12]), .sum(sum[14]), .cout(c7[13]));
FA FA218(.a(s6[14]), .b(c6[13]), .cin(c7[13]), .sum(sum[15]), .cout(c7[14]));
FA FA219(.a(s6[15]), .b(c6[14]), .cin(c7[14]), .sum(sum[16]), .cout(c7[15]));
FA FA220(.a(s6[16]), .b(c6[15]), .cin(c7[15]), .sum(sum[17]), .cout(c7[16]));
FA FA221(.a(s6[17]), .b(c6[16]), .cin(c7[16]), .sum(sum[18]), .cout(c7[17]));
FA FA222(.a(s6[18]), .b(c6[17]), .cin(c7[17]), .sum(sum[19]), .cout(c7[18]));
FA FA223(.a(s6[19]), .b(c6[18]), .cin(c7[18]), .sum(sum[20]), .cout(c7[19]));
FA FA224(.a(s6[20]), .b(c6[19]), .cin(c7[19]), .sum(sum[21]), .cout(c7[20]));
FA FA225(.a(s6[21]), .b(c6[20]), .cin(c7[20]), .sum(sum[22]), .cout(c7[21]));
FA FA226(.a(s6[22]), .b(c6[21]), .cin(c7[21]), .sum(sum[23]), .cout(c7[22]));
FA FA227(.a(s6[23]), .b(c6[22]), .cin(c7[22]), .sum(sum[24]), .cout(c7[23]));
FA FA228(.a(s6[24]), .b(c6[23]), .cin(c7[23]), .sum(sum[25]), .cout(c7[24]));
FA FA229(.a(s6[25]), .b(c6[24]), .cin(c7[24]), .sum(sum[26]), .cout(c7[25]));
FA FA230(.a(s6[26]), .b(c6[25]), .cin(c7[25]), .sum(sum[27]), .cout(c7[26]));
FA FA231(.a(s6[27]), .b(c6[26]), .cin(c7[26]), .sum(sum[28]), .cout(c7[27]));
FA FA232(.a(s6[28]), .b(c6[27]), .cin(c7[27]), .sum(sum[29]), .cout(c7[28]));
FA FA233(.a(gen_pp[15][15]), .b(c6[28]), .cin(c7[27]), .sum(sum[30]), .cout(c7[29]));

assign sum[31] = c7[29];
assign sum[0] = gen_pp[0][0]; 
endmodule