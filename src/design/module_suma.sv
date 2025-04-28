module module_suma (
    input a,b,cin,
    output reg s,cout);

    reg p,g;

    always @(*)begin
        p = a ^ b;
        g = a & b;
        s = p ^ cin;
        cout = g |(p & cin);
    end
endmodule