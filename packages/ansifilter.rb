require 'package'

class Ansifilter < Package
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.10'
  source_url 'http://www.andre-simon.de/zip/ansifilter-2.10.tar.bz2'
  source_sha256 '23d2cf439d4ed4fbec8050b2826d61c244694ce06aaf8ca7d0ec1016afebee3f'

  binary_url ({
  })
  binary_sha256 ({
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
