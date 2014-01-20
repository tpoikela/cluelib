//==============================================================================
//
// cl_crc.svh (v0.1.0)
//
// The MIT License (MIT)
//
// Copyright (c) 2013, 2014 ClueLogic, LLC
// http://cluelogic.com/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//==============================================================================

`ifndef CL_CRC_SVH
`define CL_CRC_SVH

//--------------------------------------------------------------------------
// Class: crc
//   Provides functions to calculate several CRC (cyclic redundancy check)
//   values. The type *T* must be *bit*, *logic*, or *reg*.
//--------------------------------------------------------------------------

virtual class crc #( type T = bit );

   //---------------------------------------------------------------------------
   // Typedef: bs_type
   //   Bit stream type. The shorthand of the dynamic array of type *T*.
   //---------------------------------------------------------------------------

   typedef T bs_type[];

   //-----------------------------------------------------------------------
   // Function: crc
   //   Returns a CRC value using specified taps. Supports up to 64-bit tap.
   //
   // Argument:
   //   bs     - Input bit stream.
   //   tap    - The bit vector representaion of CRC polynomial.
   //   degree - The degree of CRC polynimial.
   //
   // Returns:
   //   A CRC value.
   //-----------------------------------------------------------------------

   static function T[63:0] crc( bs_type bs,
				T[63:0] tap,
				int     degree );
      T[63:0] x = 0;
      T       y;

      foreach ( bs[i] ) begin
	 y = bs[i] ^ x[degree - 1];
	 for ( int i = degree - 1; i > 0; i-- )
	   x[i] = tap[i] ? x[i-1] ^ y : x[i-1];
	 x[0] = y;
      end // foreach ( bs[i] )
      return x;
   endfunction: crc

   //-----------------------------------------------------------------------
   // Function: crc1
   //   Returns a CRC-1 value; also known as a parity bit. 
   //   The CRC polynomial is:
   // | x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-1 value. 
   //-----------------------------------------------------------------------

   static function T crc1( bs_type bs );
      return crc( bs, 1'b0 /*not used*/, .degree( 1 ) );
   endfunction: crc1

   //-----------------------------------------------------------------------
   // Function: crc4_itu
   //   Returns a CRC-4-ITU value. 
   //   The CRC polynomial is:
   // | x^4 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-4-ITU value. 
   //-----------------------------------------------------------------------

   static function T[3:0] crc4_itu( bs_type bs );

      // 1_0011

      return crc( bs, 4'h3, .degree( 4 ) );
   endfunction: crc4_itu

   //-----------------------------------------------------------------------
   // Function: crc5_epc
   //   Returns a CRC-5-EPC value.
   //   The CRC polynomial is:
   // | x^5 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-5-EPC value.
   //-----------------------------------------------------------------------

   static function T[4:0] crc5_epc( bs_type bs );

      // 10_1001

      return crc( bs, 5'h09, .degree( 5 ) );
   endfunction: crc5_epc

   //-----------------------------------------------------------------------
   // Function: crc5_itu
   //   Returns a CRC-5-ITU value.
   //   The CRC polynomial is:
   // | x^5 + x^4 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-5-ITU value.
   //-----------------------------------------------------------------------

   static function T[4:0] crc5_itu( bs_type bs );

      // 11_0101

      return crc( bs, 5'h15, .degree( 5 ) );
   endfunction: crc5_itu

   //-----------------------------------------------------------------------
   // Function: crc5_usb
   //   Returns a CRC-5-USB value.
   //   The CRC polynomial is:
   // | x^5 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-5-USB value.
   //-----------------------------------------------------------------------

   static function T[4:0] crc5_usb( bs_type bs );

      // 10_0101

      return crc( bs, 5'h05, .degree( 5 ) );
   endfunction: crc5_usb

   //-----------------------------------------------------------------------
   // Function: crc6_cdma2000_a
   //   Returns a CRC-6-CDMA2000-A value.
   //   The CRC polynomial is:
   // | x^6 + x^5 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-6-CDMA2000-A value.
   //-----------------------------------------------------------------------

   static function T[5:0] crc6_cdma2000_a( bs_type bs );

      // 110_0111

      return crc( bs, 6'h27, .degree( 6 ) );
   endfunction: crc6_cdma2000_a

   //-----------------------------------------------------------------------
   // Function: crc6_cdma2000_b
   //   Returns a CRC-6-CDMA2000-B value.
   //   The CRC polynomial is:
   // | x^6 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   // 
   // Returns:
   //   A CRC-6-CDMA2000-B value.
   //-----------------------------------------------------------------------

   static function T[5:0] crc6_cdma2000_b( bs_type bs );

      // 100_0111

      return crc( bs, 6'h07, .degree( 6 ) );
   endfunction: crc6_cdma2000_b

   //-----------------------------------------------------------------------
   // Function: crc6_itu
   //   Returns a CRC-6-ITU value.
   //   The CRC polynomial is:
   // | x^6 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-6-ITU value.
   //-----------------------------------------------------------------------

   static function T[5:0] crc6_itu( bs_type bs );

      // 100_0011

      return crc( bs, 6'h03, .degree( 6 ) );
   endfunction: crc6_itu

   //-----------------------------------------------------------------------
   // Function: crc7
   //   Returns a CRC-7 value.
   //   The CRC polynomial is:
   // | x^7 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-7 value.
   //-----------------------------------------------------------------------

   static function T[6:0] crc7( bs_type bs );

      // 1000_1001

      return crc( bs, 7'h09, .degree( 7 ) );
   endfunction: crc7

   //-----------------------------------------------------------------------
   // Function: crc7_mvb
   //   Returns a CRC-7-MVB value.
   //   The CRC polynomial is:
   // | x^7 + x^6 + x^5 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-7-MVB value.
   //-----------------------------------------------------------------------

   static function T[6:0] crc7_mvb( bs_type bs );

      // 1110_0101

      return crc( bs, 7'h65, .degree( 7 ) );
   endfunction: crc7_mvb

   //-----------------------------------------------------------------------
   // Function: crc8
   //   Returns a CRC-8 value.
   //   The CRC polynomial is:
   // | x^8 + x^7 + x^6 + x^4 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-8 value.
   //-----------------------------------------------------------------------

   static function T[7:0] crc8( bs_type bs );

      // 1_1101_0101

      return crc( bs, 8'hD5, .degree( 8 ) );
   endfunction: crc8

   //-----------------------------------------------------------------------
   // Function: crc8_ccitt
   //   Returns a CRC-8-CCITT value.
   //   The CRC polynomial is:
   // | x^8 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-8-CCITT value.
   //-----------------------------------------------------------------------

   static function T[7:0] crc8_ccitt( bs_type bs );

      // 1_0000_0111

      return crc( bs, 8'h07, .degree( 8 ) );
   endfunction: crc8_ccitt

   //-----------------------------------------------------------------------
   // Function: crc8_dallas_maxim
   //   Returns a CRC-8-Dallas/Maxim value.
   //   The CRC polynomial is:
   // | x^8 + x^5 + x^4 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-8-Dallas/Maxim value.
   //-----------------------------------------------------------------------

   static function T[7:0] crc8_dallas_maxim( bs_type bs );

      // 1_0011_0001

      return crc( bs, 8'h31, .degree( 8 ) );
   endfunction: crc8_dallas_maxim

   //-----------------------------------------------------------------------
   // Function: crc8_sae_j1850
   //   Returns a CRC-8-SAE-J1850 value.
   //   The CRC polynomial is:
   // | x^8 + x^4 + x^3 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-8-SAE-J1850 value.
   //-----------------------------------------------------------------------

   static function T[7:0] crc8_sae_j1850( bs_type bs );

      // 1_0001_1101

      return crc( bs, 8'h1D, .degree( 8 ) );
   endfunction: crc8_sae_j1850

   //-----------------------------------------------------------------------
   // Function: crc8_wcdma
   //   Returns a CRC-8-WCDMA value.
   //   The CRC polynomial is:
   // | x^8 + x^7 + x^4 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-8-WCDMA value.
   //-----------------------------------------------------------------------

   static function T[7:0] crc8_wcdma( bs_type bs );

      // 1_1001_1011

      return crc( bs, 8'h9B, .degree( 8 ) );
   endfunction: crc8_wcdma

   //-----------------------------------------------------------------------
   // Function: crc10
   //   Returns a CRC-10 value.
   //   The CRC polynomial is:
   // | x^10 + x^9 + x^5 + x^4 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-10 value.
   //-----------------------------------------------------------------------

   static function T[9:0] crc10( bs_type bs );

      // 110_0011_0011

      return crc( bs, 10'h233, .degree( 10 ) );
   endfunction: crc10

   //-----------------------------------------------------------------------
   // Function: crc10_cdma2000
   //   Returns a CRC-10-CDMA2000 value.
   //   The CRC polynomial is:
   // | x^10 + x^9 + x^8 + x^7 + x^6 + x^4 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-10-CDMA2000 value.
   //-----------------------------------------------------------------------

   static function T[9:0] crc10_cdma2000( bs_type bs );

      // 111_1101_1001

      return crc( bs, 10'h3D9, .degree( 10 ) );
   endfunction: crc10_cdma2000

   //-----------------------------------------------------------------------
   // Function: crc11
   //   Returns a CRC-11 value.
   //   The CRC polynomial is:
   // | x^11 + x^9 + x^8 + x^7 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-11 value.
   //-----------------------------------------------------------------------

   static function T[10:0] crc11( bs_type bs );

      // 1011_1000_0101
      
      return crc( bs, 11'h385, .degree( 11 ) );
   endfunction: crc11

   //-----------------------------------------------------------------------
   // Function: crc12
   //   Returns a CRC-12 value.
   //   The CRC polynomial is:
   // | x^12 + x^11 + x^3 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-12 value.
   //-----------------------------------------------------------------------

   static function T[11:0] crc12( bs_type bs );

      // 1_1000_0000_1111

      return crc( bs, 12'h80F, .degree( 12 ) );
   endfunction: crc12

   //-----------------------------------------------------------------------
   // Function: crc12_cdma2000
   //   Returns a CRC-12-CDMA2000 value.
   //   The CRC polynomial is:
   // | x^12 + x^11 + x^10 + x^9 + x^8 + x^4 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-12-CDMA2000 value.
   //-----------------------------------------------------------------------

   static function T[11:0] crc12_cdma2000( bs_type bs );

      // 1_1111_0001_0011

      return crc( bs, 12'hF13, .degree( 12 ) );
   endfunction: crc12_cdma2000

   //-----------------------------------------------------------------------
   // Function: crc13_bbc
   //   Returns a CRC-13-BBC value.
   //   The CRC polynomial is:
   // | x^13 + x^12 + x^11 + x^10 + x^7 + x^6 + x^5 + x^4 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-13-BBC value.
   //-----------------------------------------------------------------------

   static function T[12:0] crc13_bbc( bs_type bs );

      // 11_1100_1111_0101

      return crc( bs, 13'h1CF5, .degree( 13 ) );
   endfunction: crc13_bbc

   //-----------------------------------------------------------------------
   // Function: crc15_can
   //   Returns a CRC-15-CAN value.
   //   The CRC polynomial is:
   // | x^15 + x^14 + x^10 + x^8 + x^7 + x^4 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-15-CAN value.
   //-----------------------------------------------------------------------

   static function T[14:0] crc15_can( bs_type bs );

      // 1100_0101_1001_1001

      return crc( bs, 15'h4599, .degree( 15 ) );
   endfunction: crc15_can

   //-----------------------------------------------------------------------
   // Function: crc15_mpt1327
   //   Returns a CRC-15-MPT1327 value.
   //   The CRC polynomial is:
   // | x^15 + x^14 + x^13 + x^11 + x^4 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-15-MPT1327 value.
   //-----------------------------------------------------------------------

   static function T[14:0] crc15_mpt1327( bs_type bs );

      // 1110_1000_0001_0101

      return crc( bs, 15'h6815, .degree( 15 ) );
   endfunction: crc15_mpt1327

   //-----------------------------------------------------------------------
   // Function: crc16_arinc
   //   Returns a CRC-16-ARINC value.
   //   The CRC polynomial is:
   // | x^16 + x^15 + x^13 + x^5 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-ARINC value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_arinc( bs_type bs );

      // 1_1010_0000_0010_1011

      return crc( bs, 16'hA02B, .degree( 16 ) );
   endfunction: crc16_arinc

   //-----------------------------------------------------------------------
   // Function: crc16_ccitt
   //   Returns a CRC-16-CCITT value.
   //   The CRC polynomial is:
   // | x^16 + x^12 + x^5 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-CCITT value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_ccitt( bs_type bs );

      // 1_0001_0000_0010_0001

      return crc( bs, 16'h1021, .degree( 16 ) );
   endfunction: crc16_ccitt

   //-----------------------------------------------------------------------
   // Function: crc16_cdma2000
   //   Returns a CRC-16-CDMA2000 value.
   //   The CRC polynomial is:
   // | x^16 + x^15 + x^14 + x^11 + x^6 + x^5 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-CDMA2000 value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_cdma2000( bs_type bs );

      // 1_1100_1000_0110_0111

      return crc( bs, 16'hC867, .degree( 16 ) );
   endfunction: crc16_cdma2000

   //-----------------------------------------------------------------------
   // Function: crc16_dect
   //   Returns a CRC-16-CECT value.
   //   The CRC polynomial is:
   // | x^16 + x^10 + x^8 + x^7 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-DECT value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_dect( bs_type bs );

      // 1_0000_0101_1000_1001

      return crc( bs, 16'h0589, .degree( 16 ) );
   endfunction: crc16_dect

   //-----------------------------------------------------------------------
   // Function: crc16_t10_dif
   //   Returns a CRC-16-T10-DIF value.
   //   The CRC polynomial is:
   // | x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-T10-DIF value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_t10_dif( bs_type bs );

      // 1_1000_1011_1011_0111

      return crc( bs, 16'h8BB7, .degree( 16 ) );
   endfunction: crc16_t10_dif

   //-----------------------------------------------------------------------
   // Function: crc16_dnp
   //   Returns a CRC-16-DNP value.
   //   The CRC polynomial is:
   // | x^16 + x^13 + x^12 + x^11 + x^10 + x^8 + x^6 + x^5 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-DNP value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_dnp( bs_type bs );

      // 1_0011_1101_0110_0101

      return crc( bs, 16'h3D65, .degree( 16 ) );
   endfunction: crc16_dnp

   //-----------------------------------------------------------------------
   // Function: crc16_ibm
   //   Returns a CRC-16-IBM value.
   //   The CRC polynomial is:
   // | x^16 + x^15 + x^2 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-16-IBM value.
   //-----------------------------------------------------------------------

   static function T[15:0] crc16_ibm( bs_type bs );

      // 1_1000_0000_0000_0101

      return crc( bs, 16'h8005, .degree( 16 ) );
   endfunction: crc16_ibm

   //-----------------------------------------------------------------------
   // Function: crc17_can
   //   Returns a CRC-17-CAN value.
   //   The CRC polynomial is:
   // | x^17 + x^16 + x^14 + x^13 + x^11 + x^6 + x^4 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-17-CAN value.
   //-----------------------------------------------------------------------

   static function T[16:0] crc17_can( bs_type bs );

      // 11_0110_1000_0101_1011

      return crc( bs, 17'h1_685B, .degree( 17 ) );
   endfunction: crc17_can

   //-----------------------------------------------------------------------
   // Function: crc21_can
   //   Returns a CRC-21-CAN value.
   //   The CRC polynomial is:
   // | x^21 + x^20 + x^13 + x^11 + x^7 + x^4 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-21-CAN value.
   //-----------------------------------------------------------------------

   static function T[20:0] crc21_can( bs_type bs );

      //              11_0000
      // _0010_1000_1001_1001

      return crc( bs, 21'h10_2899, .degree( 21 ) );
   endfunction: crc21_can

   //-----------------------------------------------------------------------
   // Function: crc24
   //   Returns a CRC-24 value.
   //   The CRC polynomial is:
   // | x^24 + x^22 + x^20 + x^19 + x^18 + x^16 + x^14 + x^13 + x^11 + 
   // | x^10 + x^8 + x^7 + x^6 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-24 value.
   //-----------------------------------------------------------------------

   static function T[23:0] crc24( bs_type bs );

      //          1_0101_1101
      // _0110_1101_1100_1011

      return crc( bs, 24'h5D_6DCB, .degree( 24 ) );
   endfunction: crc24

   //-----------------------------------------------------------------------
   // Function: crc24_radix_64
   //   Returns a CRC-24-Radix-64 value.
   //   The CRC polynomial is:
   // | x^24 + x^23 + x^18 + x^17 + x^14 + x^11 + x^10 + x^7 + x^6 + x^5 +
   // | x^4 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-24-Radix-64 value.
   //-----------------------------------------------------------------------

   static function T[23:0] crc24_radix_64( bs_type bs );

      //          1_1000_0110
      // _0100_1100_1111_1011
      
      return crc( bs, 24'h86_4CFB, .degree( 24 ) );
   endfunction: crc24_radix_64

   //-----------------------------------------------------------------------
   // Function: crc30
   //   Returns a CRC-30 value.
   //   The CRC polynomial is:
   // | x^30 + x^29 + x^21 + x^20 + x^15 + x^13 + x^12 + x^11 + x^8 + x^7 +
   // | x^6 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-30 value.
   //-----------------------------------------------------------------------

   static function T[29:0] crc30( bs_type bs );

      //   110_0000_0011_0000
      // _1011_1001_1100_0111

      return crc( bs, 30'h2030_B9C7, .degree( 30 ) );
   endfunction: crc30

   //-----------------------------------------------------------------------
   // Function: crc32
   //   Returns a CRC-32 value.
   //   The CRC polynomial is:
   // | x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
   // | x^5 + x^4 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-32 value.
   //-----------------------------------------------------------------------

   static function T[31:0] crc32( bs_type bs );

      // 1_0000_0100_1100_0001
      //  _0001_1101_1011_0111

      return crc( bs, 32'h04C1_1DB7, .degree( 32 ) );
   endfunction: crc32

   //-----------------------------------------------------------------------
   // Function: crc32c
   //   Returns a CRC-32C (Castagnoli) value.
   //   The CRC polynomial is:
   // | x^32 + x^28 + x^27 + x^26 + x^25 + x^23 + x^22 + x^20 + x^19 + 
   // | x^18 + x^14 + x^13 + x^11 + x^10 + x^9 + x^8 + x^6 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-32C (Castagnoli) value.
   //-----------------------------------------------------------------------

   static function T[31:0] crc32c( bs_type bs );

      // 1_0001_1110_1101_1100
      //  _0110_1111_0100_0001

      return crc( bs, 32'h1EDC_6F41, .degree( 32 ) );
   endfunction: crc32c

   //-----------------------------------------------------------------------
   // Function: crc32k
   //   Returns a CRC-32K (Koopman) value.
   //   The CRC polynomial is:
   // | x^32 + x^30 + x^29 + x^28 + x^26 + x^20 + x^19 + x^17 + x^16 + 
   // | x^15 + x^11 + x^10 + x^7 + x^6 + x^4 + x^2 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-32K (Koopman) value.
   //-----------------------------------------------------------------------

   static function T[31:0] crc32k( bs_type bs );

      // 1_0111_0100_0001_1011
      //  _1000_1100_1101_0111

      return crc( bs, 32'h741B_8CD7, .degree( 32 ) );
   endfunction: crc32k

   //-----------------------------------------------------------------------
   // Function: crc32q
   //   Returns a CRC-32Q value.
   //   The CRC polynomial is:
   // | x^32 + x^31 + x^24 + x^22 + x^16 + x^14 + x^8 + x^7 + x^5 + x^3 +
   // | x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-32Q value.
   //-----------------------------------------------------------------------

   static function T[31:0] crc32q( bs_type bs );

      // 1_1000_0001_0100_0001
      //  _0100_0001_1010_1011
      
      return crc( bs, 32'h8141_41AB, .degree( 32 ) );
   endfunction: crc32q

   //-----------------------------------------------------------------------
   // Function: crc40_gsm
   //   Returns a CRC-40-GSM value.
   //   The CRC polynomial is:
   // | x^40 + x^26 + x^23 + x^17 + x^3 + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-40-GSM value.
   //-----------------------------------------------------------------------

   static function T[39:0] crc40_gsm( bs_type bs );

      //           1_0000_0000
      //  _0000_0100_1000_0010
      //  _0000_0000_0000_1001
      
      return crc( bs, 40'h00_0482_0009, .degree( 40 ) );
   endfunction: crc40_gsm

   //-----------------------------------------------------------------------
   // Function: crc64_ecma
   //   Returns a CRC-64-ECMA value.
   //   The CRC polynomial is:
   // | x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + 
   // | x^45 + x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + 
   // | x^29 + x^27 + x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + 
   // | x^12 + x^10 + x^9 + x^7 + x^4 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-64-ECMA value.
   //-----------------------------------------------------------------------

   static function T[63:0] crc64_ecma( bs_type bs );

      // 1_0100_0010_1111_0000
      //  _1110_0001_1110_1011
      //  _1010_1001_1110_1010
      //  _0011_0110_1001_0011
      
      return crc( bs, 64'h42F0_E1EB_A9EA_3693, .degree( 64 ) );
   endfunction: crc64_ecma

   //-----------------------------------------------------------------------
   // Function: crc64_iso
   //   Returns a CRC-64-ISO value.
   //   The CRC polynomial is:
   // | x^64 + x^4 + x^3 + x + 1
   //
   // Argument:
   //   bs - Input bit stream.
   //
   // Returns:
   //   A CRC-64-ISO value.
   //-----------------------------------------------------------------------

   static function T[63:0] crc64_iso( bs_type bs );

      // 1_0000_0000_0000_0000
      //  _0000_0000_0000_0000
      //  _0000_0000_0000_0000
      //  _0000_0000_0001_1011
      
      return crc( bs, 64'h0000_0000_0000_001B, .degree( 64 ) );
   endfunction: crc64_iso

endclass: crc

`endif //  `ifndef CL_CRC_SVH

//==============================================================================
// Copyright (c) 2013, 2014 ClueLogic, LLC
// http://cluelogic.com/
//==============================================================================