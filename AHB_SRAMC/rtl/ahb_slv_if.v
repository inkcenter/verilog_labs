`define WIDTH 32

module ahb_slv_if(
    //AHB Bus Signals
    input               hsel,
    input  [`WIDTH-1:0] haddr,
    input               hwrite,
    input  [2:0]        hsize,
    input  [2:0]        hburst,
    //input [3:0] hprot,
    input  [1:0]        htrans,
    input               hready,
    input  [`WIDTH-1:0] hwdata,
    //input hmaster,
    //input hmastlock,
    output              hreadyout,
    output [1:0]        hresp,
    output [`WIDTH-1:0] hrdata,
    //output [15:0] hspilt0,
    //SRAM Bus Signals
    input  [7:0]        sram_q0,
    input  [7:0]        sram_q1,
    input  [7:0]        sram_q2,
    input  [7:0]        sram_q3,
    input  [7:0]        sram_q4,
    input  [7:0]        sram_q5,
    input  [7:0]        sram_q6,
    input  [7:0]        sram_q7,
    output [3:0]        bank0_c_sn,
    output [3:0]        bank1_c_sn,
    output              sram_w_en,
    output              sram_o_en,
    output [12:0]       sram_addr,
    output [`WIDTH-1:0] sram_wdata,
    //Global Signals
    input               hclk,
    input               hresetn
);
//Parameters for hsize
localparam BYTE = 3'b000,
           HW   = 3'b001,
           WORD = 3'b010,
//Parameters for hburst
           SINGLE = 3'b000,
           INCR   = 3'b001,
           WRAP4  = 3'b010,
           INCR4  = 3'b011,
           WRAP8  = 3'b100,
           INCR8  = 3'b101,
           WRAP16 = 3'b110,
           INCR16 = 3'b111,
//Parameters for htrans
           IDLE   = 2'b00,
           BUSY   = 2'b01,
           NONSEQ = 2'b10,
           SEQ    = 2'b11,
//Parameters for hresp
           OKAY   = 2'b00,
           ERROR  = 2'b01,
           RETRY  = 2'b10,
           SPLIT  = 2'b11,
//Base address
           BASE   = {`WIDTH{1'b0}};

//SRAM control
reg  [`WIDTH-1:0] haddr_ff;
reg  [`WIDTH-1:0] hsize_ff;
reg               hwrite_ff;
reg               hreadyout_tmp;
wire              sram_ctrl;

assign sram_o_en = 1'b0;      //output enable always
assign sram_w_en = ~hwrite_ff; //write enable 1 clock cycle after hwrite
assign hreadyout = hreadyout_tmp;

always @ (*) begin
    if (hsel && hready && (htrans!=IDLE))
        sram_ctrl = 1'b1;
    else
        sram_ctrl = 1'b0;
end

always @ (posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        haddr_ff  <= {`WIDTH{1'b0}};
        hsize_ff  <= 3'b0;
        hwrite_ff <= 1'b0;
        hreadyout_tmp <= 1'b0;
    end else if (sram_ctrl) begin
        haddr_ff  <= haddr - BASE;  //16 bits 64KB address space
        hsize_ff  <= hsize;
        hwrite_ff <= hwrite;
        if ((!hwrite) && hwrite_ff)
            hreadyout_tmp <= 1'b0;
        else
            hreadyout_tmp <= 1'b1;
    end
end

//SRAM selection
//hrdata output
always @ (*) begin
    if (!haddr_ff[15]) begin
        case (hsize_ff)
            BYTE: begin
                case (haddr_ff[1:0])
                    2'b00:   hrdata = {(`WIDTH-8){1'b0},sram_q0};
                    2'b01:   hrdata = {(`WIDTH-8){1'b0},sram_q1};
                    2'b10:   hrdata = {(`WIDTH-8){1'b0},sram_q2};
                    2'b11:   hrdata = {(`WIDTH-8){1'b0},sram_q3};
                    default: hrdata = {(`WIDTH-8){1'b0},sram_q0};
                endcase
            end
            HW: begin
                if (!haddr_ff[1])
                    hrdata = {(`WIDTH-16){1'b0},sram_q1,sram_q0};
                else
                    hrdata = {(`WIDTH-16){1'b0},sram_q3,sram_q2};
            end
            WORD: begin
                hrdata = {sram_q3,sram_q2,sram_q1,sram_q0};
            end
            default: begin
                hrdata = {sram_q3,sram_q2,sram_q1,sram_q0};
            end
        endcase
    end else begin
        case (hsize_ff)
            BYTE: begin
                case (haddr_ff[1:0])
                    2'b00:   hrdata = {(`WIDTH-8){1'b0},sram_q4};
                    2'b01:   hrdata = {(`WIDTH-8){1'b0},sram_q5};
                    2'b10:   hrdata = {(`WIDTH-8){1'b0},sram_q6};
                    2'b11:   hrdata = {(`WIDTH-8){1'b0},sram_q7};
                    default: hrdata = {(`WIDTH-8){1'b0},sram_q4};
                endcase
            end
            HW: begin
                if (!haddr_ff[1])
                    hrdata = {(`WIDTH-16){1'b0},sram_q5,sram_q4};
                else
                    hrdata = {(`WIDTH-16){1'b0},sram_q7,sram_q6};
            end
            WORD: begin
                hrdata = {sram_q7,sram_q6,sram_q5,sram_q4};
            end
            default: begin
                hrdata = {sram_q7,sram_q6,sram_q5,sram_q4};
            end
        endcase
    end
end
//hwdata wire
assign sram_wdata = hwdata;
//haddr decoder
assign sram_addr = haddr_ff[14:2];
always @ (*) begin
    if (!haddr_ff[15]) begin
        case (hsize_ff)
            BYTE: begin
                case (haddr_ff[1:0])
                    2'b00:   bank0_c_sn = 4'b1110;
                    2'b01:   bank0_c_sn = 4'b1101;
                    2'b10:   bank0_c_sn = 4'b1011;
                    2'b11:   bank0_c_sn = 4'b0111;
                    default: bank0_c_sn = 4'b1110;
                endcase
            end
            HW: begin
                if (!haddr_ff[1])
                    bank0_c_sn = 4'b1100;
                else
                    bank0_c_sn = 4'b0011;
            end
            WORD: begin
                bank0_c_sn = 4'b0000;
            end
            default: begin
                bank0_c_sn = 4'b0000;
            end
        endcase
    end else begin
        case (hsize_ff)
            BYTE: begin
                case (haddr_ff[1:0])
                    2'b00:   bank1_c_sn = 4'b1110;
                    2'b01:   bank1_c_sn = 4'b1101;
                    2'b10:   bank1_c_sn = 4'b1011;
                    2'b11:   bank1_c_sn = 4'b0111;
                    default: bank1_c_sn = 4'b1110;
                endcase
            end
            HW: begin
                if (!haddr_ff[1])
                    bank1_c_sn = 4'b1100;
                else
                    bank1_c_sn = 4'b0011;
            end
            WORD: begin
                bank1_c_sn = 4'b0000;
            end
            default: begin
                bank1_c_sn = 4'b0000;
            end
        endcase
    end
end
//hresp output


endmodule
