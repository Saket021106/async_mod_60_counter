module mod_60_counter (
    input clk,
    output [3:0] Q_10,
    output [2:0] Q_6
);

    wire gated_rst_10, gated_rst_6;

    assign gated_rst_10 = ~(Q_10[3] & Q_10[1]); 
    assign gated_rst_6  = ~(Q_6[2] & Q_6[1]);   

    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin : t_chain
            if(i == 0) begin
                t_ff T (
                    .clk(clk),
                    .rst(gated_rst_10),
                    .t(1'b1),
                    .q(Q_10[i])
                );
            end else begin
                t_ff T (
                    .clk(~Q_10[i-1]),
                    .rst(gated_rst_10),
                    .t(1'b1),
                    .q(Q_10[i])
                );
            end
        end
    endgenerate

    genvar j;
    generate
        for(j = 0; j < 3; j = j + 1) begin : t_chain_2
            if(j == 0) begin
                t_ff T (
                    .clk(~Q_10[3]), 
                    .rst(gated_rst_6),
                    .t(1'b1),
                    .q(Q_6[j])      
                );
            end else begin
                t_ff T (
                    .clk(~Q_6[j-1]), 
                    .rst(gated_rst_6),
                    .t(1'b1),
                    .q(Q_6[j])       
                );
            end
        end
    endgenerate

endmodule

module t_ff (
    input clk,
    input rst,
    input t,
    output reg q = 1'b0
);

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            q <= 1'b0;
        end else begin
            if (t) 
                q <= ~q;
            else
                q <= q;
        end
    end

endmodule
