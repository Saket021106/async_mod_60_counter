`timescale 1ns/1ps  

module tb_mod_60_counter;

    reg clk;
    wire [3:0] Q_10;
    wire [2:0] Q_6;

    mod_60_counter dut (
        .clk(clk),
        .Q_10(Q_10),
        .Q_6(Q_6)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_mod_60_counter);

        $monitor("S1 = %d, S0 = %d", Q_6, Q_10);
        #600;

        $finish;
    end

endmodule
