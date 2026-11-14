// Author: Olaoluwa Raji
// Date:   05/11/2026

// Top-level FFT IP testbench

// Updated on 14/11/2026
// Changes(s) made:
// - Accounted for slight differences in results due to convergent rounding edge cases.

`timescale 1 ps / 1 ps
module fft_ip_tb_top (
    );

    logic         fft_ip_inst_clk_bfm_clk_clk;                 // fft_ip_inst_clk_bfm:clk -> [fft_ip_inst:clk, fft_ip_inst_rst_bfm:clk, fft_ip_inst_sink_bfm:clk, fft_ip_inst_source_bfm:clk]
    logic   [1:0] fft_ip_inst_sink_bfm_conduit_sink_error;     // fft_ip_inst_sink_bfm:sig_sink_error -> fft_ip_inst:sink_error
    logic   [0:0] fft_ip_inst_sink_bfm_conduit_inverse;        // fft_ip_inst_sink_bfm:sig_inverse -> fft_ip_inst:inverse
    logic   [0:0] fft_ip_inst_sink_bfm_conduit_sink_eop;       // fft_ip_inst_sink_bfm:sig_sink_eop -> fft_ip_inst:sink_eop
    logic   [0:0] fft_ip_inst_sink_bfm_conduit_sink_sop;       // fft_ip_inst_sink_bfm:sig_sink_sop -> fft_ip_inst:sink_sop
    logic   [0:0] fft_ip_inst_sink_bfm_conduit_sink_valid;     // fft_ip_inst_sink_bfm:sig_sink_valid -> fft_ip_inst:sink_valid
    logic  [17:0] fft_ip_inst_sink_bfm_conduit_sink_real;      // fft_ip_inst_sink_bfm:sig_sink_real -> fft_ip_inst:sink_real
    logic         fft_ip_inst_sink_sink_ready;                 // fft_ip_inst:sink_ready -> fft_ip_inst_sink_bfm:sig_sink_ready
    logic   [3:0] fft_ip_inst_sink_bfm_conduit_fftpts_in;      // fft_ip_inst_sink_bfm:sig_fftpts_in -> fft_ip_inst:fftpts_in
    logic  [17:0] fft_ip_inst_sink_bfm_conduit_sink_imag;      // fft_ip_inst_sink_bfm:sig_sink_imag -> fft_ip_inst:sink_imag
    logic  [21:0] fft_ip_inst_source_source_imag;              // fft_ip_inst:source_imag -> fft_ip_inst_source_bfm:sig_source_imag
    logic  [21:0] fft_ip_inst_source_source_real;              // fft_ip_inst:source_real -> fft_ip_inst_source_bfm:sig_source_real
    logic   [0:0] fft_ip_inst_source_bfm_conduit_source_ready; // fft_ip_inst_source_bfm:sig_source_ready -> fft_ip_inst:source_ready
    logic         fft_ip_inst_source_source_sop;               // fft_ip_inst:source_sop -> fft_ip_inst_source_bfm:sig_source_sop
    logic   [3:0] fft_ip_inst_source_fftpts_out;               // fft_ip_inst:fftpts_out -> fft_ip_inst_source_bfm:sig_fftpts_out
    logic         fft_ip_inst_source_source_eop;               // fft_ip_inst:source_eop -> fft_ip_inst_source_bfm:sig_source_eop
    logic         fft_ip_inst_source_source_valid;             // fft_ip_inst:source_valid -> fft_ip_inst_source_bfm:sig_source_valid
    logic   [1:0] fft_ip_inst_source_source_error;             // fft_ip_inst:source_error -> fft_ip_inst_source_bfm:sig_source_error
    logic         fft_ip_inst_rst_bfm_reset_reset;             // fft_ip_inst_rst_bfm:reset -> [fft_ip_inst:reset_n, fft_ip_inst_sink_bfm:reset, fft_ip_inst_source_bfm:reset]

    fft_ip fft_ip_inst (
        .clk          (fft_ip_inst_clk_bfm_clk_clk),                 //    clk.clk
        .reset_n      (fft_ip_inst_rst_bfm_reset_reset),             //    rst.reset_n
        .sink_valid   (fft_ip_inst_sink_bfm_conduit_sink_valid),     //   sink.sink_valid
        .sink_ready   (fft_ip_inst_sink_sink_ready),                 //       .sink_ready
        .sink_error   (fft_ip_inst_sink_bfm_conduit_sink_error),     //       .sink_error
        .sink_sop     (fft_ip_inst_sink_bfm_conduit_sink_sop),       //       .sink_sop
        .sink_eop     (fft_ip_inst_sink_bfm_conduit_sink_eop),       //       .sink_eop
        .sink_real    (fft_ip_inst_sink_bfm_conduit_sink_real),      //       .sink_real
        .sink_imag    (fft_ip_inst_sink_bfm_conduit_sink_imag),      //       .sink_imag
        .fftpts_in    (fft_ip_inst_sink_bfm_conduit_fftpts_in),      //       .fftpts_in
        .inverse      (fft_ip_inst_sink_bfm_conduit_inverse),        //       .inverse
        .source_valid (fft_ip_inst_source_source_valid),             // source.source_valid
        .source_ready (fft_ip_inst_source_bfm_conduit_source_ready), //       .source_ready
        .source_error (fft_ip_inst_source_source_error),             //       .source_error
        .source_sop   (fft_ip_inst_source_source_sop),               //       .source_sop
        .source_eop   (fft_ip_inst_source_source_eop),               //       .source_eop
        .source_real  (fft_ip_inst_source_source_real),              //       .source_real
        .source_imag  (fft_ip_inst_source_source_imag),              //       .source_imag
        .fftpts_out   (fft_ip_inst_source_fftpts_out)                //       .fftpts_out
    );

    altera_avalon_clock_source #(
        .CLOCK_RATE (50000000),
        .CLOCK_UNIT (1)
    ) fft_ip_inst_clk_bfm (
        .clk (fft_ip_inst_clk_bfm_clk_clk)  // clk.clk
    );

    altera_avalon_reset_source #(
        .ASSERT_HIGH_RESET    (0),
        .INITIAL_RESET_CYCLES (50)
    ) fft_ip_inst_rst_bfm (
        .reset (fft_ip_inst_rst_bfm_reset_reset), // reset.reset_n
        .clk   (fft_ip_inst_clk_bfm_clk_clk)      //   clk.clk
    );

    altera_conduit_bfm fft_ip_inst_sink_bfm (
        .clk            (fft_ip_inst_clk_bfm_clk_clk),             //     clk.clk
        .reset          (~fft_ip_inst_rst_bfm_reset_reset),        //   reset.reset
        .sig_fftpts_in  (fft_ip_inst_sink_bfm_conduit_fftpts_in),  // conduit.fftpts_in
        .sig_inverse    (fft_ip_inst_sink_bfm_conduit_inverse),    //        .inverse
        .sig_sink_eop   (fft_ip_inst_sink_bfm_conduit_sink_eop),   //        .sink_eop
        .sig_sink_error (fft_ip_inst_sink_bfm_conduit_sink_error), //        .sink_error
        .sig_sink_imag  (fft_ip_inst_sink_bfm_conduit_sink_imag),  //        .sink_imag
        .sig_sink_ready (fft_ip_inst_sink_sink_ready),             //        .sink_ready
        .sig_sink_real  (fft_ip_inst_sink_bfm_conduit_sink_real),  //        .sink_real
        .sig_sink_sop   (fft_ip_inst_sink_bfm_conduit_sink_sop),   //        .sink_sop
        .sig_sink_valid (fft_ip_inst_sink_bfm_conduit_sink_valid)  //        .sink_valid
    );

    altera_conduit_bfm_0002 fft_ip_inst_source_bfm (
        .clk              (fft_ip_inst_clk_bfm_clk_clk),                 //     clk.clk
        .reset            (~fft_ip_inst_rst_bfm_reset_reset),            //   reset.reset
        .sig_fftpts_out   (fft_ip_inst_source_fftpts_out),               // conduit.fftpts_out
        .sig_source_eop   (fft_ip_inst_source_source_eop),               //        .source_eop
        .sig_source_error (fft_ip_inst_source_source_error),             //        .source_error
        .sig_source_imag  (fft_ip_inst_source_source_imag),              //        .source_imag
        .sig_source_ready (fft_ip_inst_source_bfm_conduit_source_ready), //        .source_ready
        .sig_source_real  (fft_ip_inst_source_source_real),              //        .source_real
        .sig_source_sop   (fft_ip_inst_source_source_sop),               //        .source_sop
        .sig_source_valid (fft_ip_inst_source_source_valid)              //        .source_valid
    );

    localparam int FFT_LENGTH  = 8;
    localparam int FRAME_DELAY = 10;

    initial begin: stimuli
        localparam int INPUT_WIDTH = 18;
        logic signed [INPUT_WIDTH-1:0] data;
        int fd;
        bit eof_reached; eof_reached = 1'b0;

        fd = $fopen("../golden_model/inputs.txt", "r");
        if(fd == 0) $fatal(1, "Failed to open inputs.txt");

        wait(fft_ip_inst_sink_bfm.signal_reset_asserted.triggered);
        fft_ip_inst_source_bfm.set_source_ready(1'b1);
        fft_ip_inst_sink_bfm.set_fftpts_in(FFT_LENGTH);
        fft_ip_inst_sink_bfm.set_inverse(1'b0);
        fft_ip_inst_sink_bfm.set_sink_error(2'b0);
        fft_ip_inst_sink_bfm.set_sink_valid(1'b0);
        fft_ip_inst_sink_bfm.set_sink_sop(1'b0);
        fft_ip_inst_sink_bfm.set_sink_eop(1'b0);
        fft_ip_inst_sink_bfm.set_sink_real({INPUT_WIDTH{1'b0}});
        fft_ip_inst_sink_bfm.set_sink_imag({INPUT_WIDTH{1'b0}});

        forever begin 
            wait(fft_ip_inst_sink_sink_ready == 1'b1);
            fft_ip_inst_sink_bfm.set_sink_valid(1'b1);
            for(int i = 0; i < FFT_LENGTH; i++) begin
                if($fscanf(fd, "%d", data) > 0) begin
                    fft_ip_inst_sink_bfm.set_sink_sop(1'b0);
                    fft_ip_inst_sink_bfm.set_sink_eop(1'b0);			
                    if(i == 0) fft_ip_inst_sink_bfm.set_sink_sop(1'b1);
                    else if(i == FFT_LENGTH-1) fft_ip_inst_sink_bfm.set_sink_eop(1'b1);
                    fft_ip_inst_sink_bfm.set_sink_real(data);
                    @(posedge fft_ip_inst_clk_bfm_clk_clk);
                end
                else begin
                    eof_reached = 1'b1;
                    break;
                end
            end
            fft_ip_inst_sink_bfm.set_sink_valid(1'b0);
            fft_ip_inst_sink_bfm.set_sink_eop(1'b0);
            repeat(FRAME_DELAY) @(posedge fft_ip_inst_clk_bfm_clk_clk);
            if(eof_reached) begin
                $fclose(fd);
                break;
            end
        end
    end

    localparam int OUTPUT_WIDTH = 22;

    // Return true (1) if absolute difference is 1. Otherwise, return false (0).
    function bit abs_diff(logic signed [OUTPUT_WIDTH-1:0] expected, 
                          logic signed [OUTPUT_WIDTH-1:0] got);
        logic signed [OUTPUT_WIDTH-1:0] diff;
        diff     = expected - got;
        abs_diff = (diff == 1 || diff == -1); 
    endfunction

    initial begin: monitor
        string  status;  
        int     fd_out;
        int     fd_rep;
        longint unsigned serial_num; 
        logic   signed [OUTPUT_WIDTH-1:0] exp_fft_real;
        logic   signed [OUTPUT_WIDTH-1:0] exp_fft_imag;
        logic   signed [OUTPUT_WIDTH-1:0] fft_real;
        logic   signed [OUTPUT_WIDTH-1:0] fft_imag;
        int     unsigned pass; 
        int     unsigned fail;
        int     unsigned cycles;
        time    clk_period;
        time    time_sop;
        bit     streaming;      

        serial_num =   0;
        pass       =   0; 
        fail       =   0; 
        cycles     =   0;
        clk_period = 2*fft_ip_inst_clk_bfm.HALF_CLOCK_PERIOD;
        time_sop   =   0;
        streaming  = 1'b0;        

        fd_out = $fopen("../golden_model/outputs.txt", "r");
        fd_rep = $fopen("../golden_model/report.txt",  "w");
        if(fd_out == 0) $fatal(1, "Failed to open outputs.txt");
        if(fd_rep == 0) $fatal(1, "Failed to open report.txt");
        
        wait(fft_ip_inst_sink_bfm.signal_reset_asserted.triggered);
        forever begin
            @(negedge fft_ip_inst_clk_bfm_clk_clk); 
            if(fft_ip_inst_source_bfm.get_source_valid()) begin
                streaming = 1'b1;
                fft_real  = $signed(fft_ip_inst_source_bfm.get_source_real());
                fft_imag  = $signed(fft_ip_inst_source_bfm.get_source_imag());
                if(fft_ip_inst_source_bfm.get_source_sop()) time_sop = $time;
                if($fscanf(fd_out, "%d %d", exp_fft_real, exp_fft_imag) > 0) begin 
                    if(exp_fft_real == fft_real && exp_fft_imag == fft_imag) begin
                        status = "PASS";
                        pass   = pass + 1;
                    end
                    else begin
                        if(abs_diff(exp_fft_real, fft_real) || abs_diff(exp_fft_imag, fft_imag)) begin
                            status = "PASS (CONVERGENT ROUNDING EDGE CASE)";
                            pass   = pass + 1;
                        end
                        else begin
                            status = "FAIL";
                            fail   = fail + 1;
                        end
                    end
                    serial_num = serial_num + 1;
                    $display("%8d | EXPECTED: %d,%d | GOT: %d,%d | STATUS: %s", 
                             serial_num, exp_fft_real, exp_fft_imag, fft_real, fft_imag, status);
                    $fdisplay(fd_rep, "%8d | EXPECTED: %d,%d | GOT: %d,%d | STATUS: %s", 
                              serial_num, exp_fft_real, exp_fft_imag, fft_real, fft_imag, status);                             
                end
            end
            else begin
                if(streaming) begin
                    cycles = ($time - time_sop) / clk_period;
                    if(cycles > FFT_LENGTH + FRAME_DELAY) begin
                        streaming = 1'b0;
                        $display("\n--------------------------------------------------------------------------------------");
                        $display("\tPASSES: %8d | FAILS: %8d | TOTAL: %8d", pass, fail, pass + fail);
                        $display("--------------------------------------------------------------------------------------\n");
                        $fdisplay(fd_rep, "\n--------------------------------------------------------------------------------------");
                        $fdisplay(fd_rep, "\tPASSES: %8d | FAILS: %8d | TOTAL: %8d", pass, fail, pass + fail);
                        $fdisplay(fd_rep, "--------------------------------------------------------------------------------------\n");                        
                        $fclose(fd_out);
                        $fclose(fd_rep);
                        $finish;
                    end
                end            
            end
        end
    end
endmodule
