require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.5'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.5.tar.gz'
  source_sha256 '870920011285b919fca5c60eaa5670312eeffe3883dd8cf564cd1179fc639336'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'util_linux'
  depends_on 'automake'
  depends_on 'libxslt'
  depends_on 'libtool'
  depends_on 'gperf'
  depends_on 'automake' => :build
  depends_on 'util_linux' => :build

  def self.build
    system 'autoreconf -f -i -s'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
