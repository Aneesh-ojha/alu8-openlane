`timescale 1ns/1ps
module alu8_tb;
    reg  [7:0] a, b;
    reg  [2:0] opcode;
    wire [7:0] result;
    wire       carry_out, zero_flag;

    alu8 uut (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .carry_out(carry_out), .zero_flag(zero_flag)
    );

    initial begin
        $dumpfile("alu8_tb.vcd");
        $dumpvars(0, alu8_tb);

        a = 8'd15; b = 8'd10; opcode = 3'b000; #10; // ADD
        a = 8'd15; b = 8'd10; opcode = 3'b001; #10; // SUB
        a = 8'hF0; b = 8'h0F; opcode = 3'b010; #10; // AND
        a = 8'hF0; b = 8'h0F; opcode = 3'b011; #10; // OR
        a = 8'hFF; b = 8'h0F; opcode = 3'b100; #10; // XOR
        a = 8'h0F; b = 8'h00; opcode = 3'b101; #10; // NOT
        a = 8'h01; b = 8'h00; opcode = 3'b110; #10; // SHL
        a = 8'h80; b = 8'h00; opcode = 3'b111; #10; // SHR
        a = 8'd0;  b = 8'd0;  opcode = 3'b000; #10; // ADD zero check

        #10 $finish;
    end

    initial begin
        $monitor("t=%0t opcode=%b a=%d b=%d result=%d carry=%b zero=%b",
                   $time, opcode, a, b, result, carry_out, zero_flag);
    end
endmodule
