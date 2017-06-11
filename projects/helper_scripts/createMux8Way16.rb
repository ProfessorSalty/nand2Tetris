#!/usr/bin/env ruby

def create_mux_4_way_16
  preamble = "// This file is part of www.nand2tetris.org
// and the book \"The Elements of Computing Systems\"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Mux8Way16.hdl

/**
 * 8-way 16-bit multiplexor:
 * out = a if sel == 000
 *       b if sel == 001
 *       etc.
 *       h if sel == 111
 */

CHIP Mux8Way16 {
    IN a[16], b[16], c[16], d[16],
       e[16], f[16], g[16], h[16],
       sel[3];
    OUT out[16];

    PARTS:\n\n"
  footer = "}"

  output = (0..15).map do |i|
    "\tMux(a=a[#{i}], b=e[#{i}], sel=sel[2], out=out#{i}1Stage1);
    Mux(a=b[#{i}], b=f[#{i}], sel=sel[2], out=out#{i}2Stage1);
    Mux(a=c[#{i}], b=g[#{i}], sel=sel[2], out=out#{i}3Stage1);
    Mux(a=d[#{i}], b=h[#{i}], sel=sel[2], out=out#{i}4Stage1);

    Mux(a=out#{i}1Stage1, b=out#{i}3Stage1, sel=sel[1], out=out#{i}1Stage2);
    Mux(a=out#{i}2Stage1, b=out#{i}4Stage1, sel=sel[1], out=out#{i}2Stage2);

    Mux(a=out#{i}1Stage2, b=out#{i}2Stage2, sel=sel[0], out=out[#{i}]);\n\n"
  end
  open("Mux8Way16.hdl", 'w') do |f|
    f.puts preamble + output.join + footer
  end
end

create_mux_4_way_16