require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2018-03-13'
  source_url 'https://ftpmirror.gnu.org/gnu/autoconf-archive/autoconf-archive-2018.03.13.tar.xz'
  source_sha256 '6175f90d9fa64c4d939bdbb3e8511ae0ee2134863a2c7bf8d9733819efa6e159'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'perl'
  depends_on 'm4'
  depends_on 'autoconf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
