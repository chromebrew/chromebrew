require 'package'

class Svgalib < Package
  description 'SVGAlib is a low-level graphics library for Linux. It augments the C programming language, which doesn\'t provide support for graphics.'
  homepage 'https://www.svgalib.org/'
  version 'e698'
  source_url 'https://github.com/ryanmcgrath/svgalib-1/archive/e698d8c11f938bb6039a1791dc54c620c228d308.tar.gz'
  source_sha256 'ff39a2b375c36b688934d4be88193b1fd02d3809fa398dbf51d0fcd182087452'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    system "sed -i 's,#ifndef __GNUC__,#ifdef __GNUC__,g' threeDKit/quickmath.h"
    system "sed -i '/ldconfig/d' src/Makefile threeDKit/Makefile Makefile lrmi-0.9/Makefile.lrmi"
    system "sed -i -e 's,#!/usr/bin/perl,#!#{CREW_PREFIX}/bin/perl,g' -e 's,/usr/lib/kbd,#{CREW_PREFIX}/lib/kbd,g' utils/svgakeymap"
  end

  def self.build
    make_cmd = "make \
                NO_ASM=y \
                NO_HELPER=y \
                BACKGROUND=y \
                prefix=#{CREW_PREFIX} \
                libdir=#{CREW_LIB_PREFIX} \
                LIBDIR=#{CREW_LIB_PREFIX} \
                shlibdir=#{CREW_LIB_PREFIX} \
                datadir=#{CREW_PREFIX}/etc/vga \
                mandir=#{CREW_PREFIX}/share/man \
                sharedlibdir=#{CREW_LIB_PREFIX} \
                rulesdir=#{CREW_PREFIX}/etc/udev/rules.d"
    system "#{make_cmd} install"
  end

  def self.install
    make_cmd = "make \
                NO_ASM=y \
                NO_HELPER=y \
                BACKGROUND=y \
                prefix=#{CREW_DEST_PREFIX} \
                libdir=#{CREW_DEST_LIB_PREFIX} \
                LIBDIR=#{CREW_DEST_LIB_PREFIX} \
                shlibdir=#{CREW_DEST_LIB_PREFIX} \
                datadir=#{CREW_DEST_PREFIX}/etc/vga \
                mandir=#{CREW_DEST_PREFIX}/share/man \
                sharedlibdir=#{CREW_DEST_LIB_PREFIX} \
                rulesdir=#{CREW_DEST_PREFIX}/etc/udev/rules.d"
    system "#{make_cmd} install"
    system "#{make_cmd} demoprogs"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/kbd/keytables"
    system "gzip -9 /dev/null -c > #{CREW_DEST_PREFIX}/lib/kbd/keytables/us.map.gz"
  end
end
