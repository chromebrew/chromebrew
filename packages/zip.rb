require 'package'

class Zip < Package
  description 'Zip is a compression and file packaging/archive utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://infozip.sourceforge.net/Zip.html'
  @_ver = '3.0-12'
  version @_ver
  license 'Info-ZIP'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/infozip/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz'
  source_sha256 'f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369'

  depends_on 'bz2' => :build

  extra_url "https://httpredir.debian.org/debian/pool/main/z/zip/zip_#{@_ver}.debian.tar.xz" => '522174080773f72882bd240ca384e698134f61ad6405ce8f995e1d21c9ba41d8'

  def self.patch
    system "tar xf zip_#{@_ver}.debian.tar.xz"
    system "for patch in $(cat debian/patches/series); do patch -p 1 -i debian/patches/${patch}; done"

    system "sed -i 's:CC = cc:CC = #{CREW_TGT}-gcc #{CREW_COMMON_FLAGS}:' unix/Makefile"
    system "sed -i 's:CPP = /lib/cpp:CPP = $(which cpp):' unix/Makefile"
    system "sed -i 's:INSTALL_PROGRAM = cp:INSTALL_PROGRAM = install:' unix/Makefile"
    system "sed -i 's:INSTALL_D = mkdir -p:INSTALL_D = install -d:' unix/Makefile"
    system "sed -i 's:prefix = /usr/local:prefix = #{CREW_PREFIX}:' unix/Makefile"
    system "sed -i 's:CFLAGS = -O2:CFLAGS =:' unix/Makefile"
  end

  def self.build
    system 'make -f unix/Makefile generic'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_PREFIX}/share/man/man1", "-f", "unix/Makefile", "install"
  end
end
