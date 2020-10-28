//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Oct 28 17:31:31 2020
// Version: v11.8 11.8.0.26
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// Voltage_Monitor
module Voltage_Monitor(
    // Inputs
    MSS_RESET_N,
    TM0_Voltage,
    UART_0_RXD,
    VAREF0,
    // Outputs
    GPIO_28_OUT,
    GPIO_29_OUT,
    GPIO_30_OUT,
    GPIO_31_OUT,
    UART_0_TXD
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  MSS_RESET_N;
input  TM0_Voltage;
input  UART_0_RXD;
input  VAREF0;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output GPIO_28_OUT;
output GPIO_29_OUT;
output GPIO_30_OUT;
output GPIO_31_OUT;
output UART_0_TXD;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   GPIO_28_OUT_net_0;
wire   GPIO_29_OUT_net_0;
wire   GPIO_30_OUT_net_0;
wire   GPIO_31_OUT_net_0;
wire   MSS_RESET_N;
wire   TM0_Voltage;
wire   UART_0_RXD;
wire   UART_0_TXD_net_0;
wire   VAREF0;
wire   UART_0_TXD_net_1;
wire   GPIO_31_OUT_net_1;
wire   GPIO_30_OUT_net_1;
wire   GPIO_29_OUT_net_1;
wire   GPIO_28_OUT_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign UART_0_TXD_net_1  = UART_0_TXD_net_0;
assign UART_0_TXD        = UART_0_TXD_net_1;
assign GPIO_31_OUT_net_1 = GPIO_31_OUT_net_0;
assign GPIO_31_OUT       = GPIO_31_OUT_net_1;
assign GPIO_30_OUT_net_1 = GPIO_30_OUT_net_0;
assign GPIO_30_OUT       = GPIO_30_OUT_net_1;
assign GPIO_29_OUT_net_1 = GPIO_29_OUT_net_0;
assign GPIO_29_OUT       = GPIO_29_OUT_net_1;
assign GPIO_28_OUT_net_1 = GPIO_28_OUT_net_0;
assign GPIO_28_OUT       = GPIO_28_OUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------Voltage_Monitor_MSS
Voltage_Monitor_MSS Voltage_Monitor_MSS_0(
        // Inputs
        .UART_0_RXD  ( UART_0_RXD ),
        .MSS_RESET_N ( MSS_RESET_N ),
        .TM0_Voltage ( TM0_Voltage ),
        .VAREF0      ( VAREF0 ),
        // Outputs
        .UART_0_TXD  ( UART_0_TXD_net_0 ),
        .GPIO_31_OUT ( GPIO_31_OUT_net_0 ),
        .GPIO_30_OUT ( GPIO_30_OUT_net_0 ),
        .GPIO_29_OUT ( GPIO_29_OUT_net_0 ),
        .GPIO_28_OUT ( GPIO_28_OUT_net_0 ) 
        );


endmodule
