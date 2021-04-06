require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.6-2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool/archive/2.0.6.tar.gz'
  source_sha256 'bda0b08e9a1db885c9d7d1545535e9814dd8931d5b8dd5ab4a47bd769d0130c6'

  depends_on 'libxml2'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto -O2 -fuse-ld=gold' \
                CXXFLAGS='-pipe -flto=auto -O2 -fuse-ld=gold' \
                LDFLAGS='-flto=auto' \
                PYTHON='#{CREW_PREFIX}/bin/python3' \
            ./configure #{CREW_OPTIONS}"
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
