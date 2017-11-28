require 'package'

class Libslz < Package
  description 'SLZ is a fast and memory-less stream compressor which produces an output that can be decompressed with zlib or gzip.'
  homepage 'http://www.libslz.org/'
  version '1.1.0-2'
  source_url 'http://git.1wt.eu/web?p=libslz.git;a=snapshot;h=f65544ca6a0d628b1db2d76069cc3be493543d38;sf=tbz2'
  source_sha256 '985cb527a4d1c7a93e9eb19d79f97513eb57cfe6e112b727976855c8144ffccc'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,LIBDIR     := \$(PREFIX)/lib,LIBDIR     := #{CREW_LIB_PREFIX},' Makefile"
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
