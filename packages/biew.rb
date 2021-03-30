require 'package'

class Biew < Package
  description 'EYE (Binary EYE) is a free, portable, advanced file viewer with built-in editor for binary, hexadecimal and disassembler modes.'
  homepage 'https://sourceforge.net/projects/beye/'
  version '6.1.0-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/beye/biew/6.1.0/biew-610-src.tar.bz2'
  source_sha256 '2e85f03c908dd6ec832461fbfbc79169a33f4caccf48c8fe60cbd29f5fb06d17'

  depends_on 'apriconv'
  depends_on 'ncursesw'
  depends_on 'slang'

  def self.build
    system "cp -r ./biewlib/sysdep/generic ./biewlib/sysdep/arm" # add arm support
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
