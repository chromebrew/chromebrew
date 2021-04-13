require 'package'

class Ansifilter < Package
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.10'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'http://www.andre-simon.de/zip/ansifilter-2.10.tar.bz2'
  source_sha256 '23d2cf439d4ed4fbec8050b2826d61c244694ce06aaf8ca7d0ec1016afebee3f'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ansifilter-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ansifilter-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/ansifilter-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/ansifilter-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd5a8d33520c76aeb3f13067f169300d4b959a78ef352331b14a1b70db9f44f5f',
     armv7l: 'd5a8d33520c76aeb3f13067f169300d4b959a78ef352331b14a1b70db9f44f5f',
       i686: 'b312b46ae42dfb60620e6f62caa5aae83bfe259e01094d84f2dd949a137eedf2',
     x86_64: 'af4c1a4f1b9fddd1efa5dabded1664880bd25fc17b52290af956d4d5d7dedf5c',
  })

  def self.build
    system 'mv makefile Makefile'
    system "sed -i 's,DESTDIR = ,DESTDIR = #{CREW_DEST_DIR},' Makefile"
    system "sed -i 's,PREFIX = /usr,PREFIX = #{CREW_PREFIX},' Makefile"
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
