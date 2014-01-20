//==============================================================================
// cl_comparator.svh (v0.1.0)
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

`ifndef CL_COMPARATOR_SVH
`define CL_COMPARATOR_SVH

//------------------------------------------------------------------------------
// Class: comparator
//   Provides compare strategies.
//------------------------------------------------------------------------------

class comparator#( type T = int );

   //---------------------------------------------------------------------------
   // Function: eq
   //   Returns 1 if two inputs are equal.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is equal to *y*, then returns 1. Otherwise, returns 0.
   //---------------------------------------------------------------------------

   virtual function bit eq( T x, T y );
      return x == y;
   endfunction: eq

   // Operator overloading is not supported?
   // bind == function bit eq( T x, T y );

   //---------------------------------------------------------------------------
   // Function: ne
   //   Returns 1 if two inputs are not equal.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is not equal to *y*, then returns 1. Otherwise, returns 0.
   //---------------------------------------------------------------------------

   virtual function bit ne( T x, T y );
      return ! eq( x, y );
   endfunction: ne

   //---------------------------------------------------------------------------
   // Function: lt
   //   Returns 1 if *x* is less than *y*.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is less than *y*, then returns 1. Otherwise, returns 0.
   //---------------------------------------------------------------------------

   virtual function bit lt( T x, T y );
      return x < y;
   endfunction: lt

   //---------------------------------------------------------------------------
   // Function: gt
   //   Returns 1 if *x* is greater than *y*.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is greater than *y*, then returns 1. Otherwise, returns 0.
   //---------------------------------------------------------------------------

   virtual function bit gt( T x, T y );
      return x > y;
   endfunction: gt

   //---------------------------------------------------------------------------
   // Function: le
   //   Returns 1 if *x* is less than or equal to *y*.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is less than or equal to *y*, then returns 1. Otherwise, returns
   //   0.
   //---------------------------------------------------------------------------

   virtual function bit le( T x, T y );
      return ! gt( x, y );
   endfunction: le

   //---------------------------------------------------------------------------
   // Function: ge
   //   Returns 1 if *x* is greater than or equal to *y*.
   //
   // Arguments:
   //   x - An input of type T.
   //   y - Another input of type T.
   //
   // Returns:
   //   If *x* is greaterthan or equal to *y*, then returns 1. Otherwise,
   //   returns 0.
   //---------------------------------------------------------------------------

   virtual function bit ge( T x, T y );
      return ! lt( x, y );
   endfunction: ge

endclass: comparator

`endif //  `ifndef CL_COMPARATOR_SVH

//==============================================================================
// Copyright (c) 2013, 2014 ClueLogic, LLC
// http://cluelogic.com/
//==============================================================================