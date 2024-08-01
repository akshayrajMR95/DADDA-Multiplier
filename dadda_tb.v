module tb();
    reg [15:0] A, B;
    wire [31:0] sum;

    // Instantiate the Dadda multiplier
    dadda_16 uut (
        .A(A),
        .B(B),
        .sum(sum)
    );

    initial begin
         Initialize inputs
        A = 16'h0000; B = 16'h0000;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         Test case 1
        A = 16'h0008; B = 16'h0004;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         Test case 2
        A = 16'hFFFF; B = 16'h0001;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         Test case 3
        A = 16'h1234; B = 16'h5678;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         Test case 4
        A = 16'hABCD; B = 16'hEF01;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         Test case 5
        A = 16'h8000; B = 16'h8000;
        #10;
        $display("A = %h, B = %h, sum = %h", A, B, sum);

         End simulation
        $stop;
    end

endmodule