require 'package'

class Unzip < Package
  description 'UnZip is an extraction utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://infozip.sourceforge.net/UnZip.html'
  @_ver = '6.0-26'
  version @_ver
  license 'Info-ZIP'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz'
  source_sha256 '036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37'

  depends_on 'compressdoc' => :build
  depends_on 'patch' => :build

  extra_url "https://httpredir.debian.org/debian/pool/main/u/unzip/unzip_#{@_ver}.debian.tar.xz" => '88cb7c0f1fd13252b662dfd224b64b352f9e75cd86389557fcb23fa6d2638599'

  def self.patch
    system "tar xf unzip_#{@_ver}.debian.tar.xz"
    system "for patch in $(cat debian/patches/series); do patch -p 1 -i debian/patches/${patch}; done"

    system "sed -i 's:CC = cc:CC = #{CREW_TGT}-gcc #{CREW_COMMON_FLAGS}:' unix/Makefile"
    system "sed -i 's:CPP = /lib/cpp:CPP = $(which cpp):' unix/Makefile"
    system "sed -i 's:INSTALL_PROGRAM = cp:INSTALL_PROGRAM = install:' unix/Makefile"
    system "sed -i 's:INSTALL_D = mkdir -p:INSTALL_D = install -d:' unix/Makefile"
    system "sed -i 's:prefix = /usr/local:prefix = #{CREW_PREFIX}:' unix/Makefile"
    system "sed -i 's:CFLAGS = -O:CFLAGS =:' unix/Makefile"
  end

  def self.build
    # LCHMOD is not supported in linux.
    system 'echo "CFLAGS=-DNO_LCHMOD" >> flags'
    system "make -f unix/Makefile generic"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", "-f", "unix/Makefile", "install"
  end
end
