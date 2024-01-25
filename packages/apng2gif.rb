require 'package'

class Apng2gif < Package
  description 'Convert APNG animations into animated GIF format.'
  homepage 'https://sourceforge.net/projects/apng2gif/'
  version '1.8'
  license 'ZLIB'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/apng2gif/files/#{version}/apng2gif-#{version}-src.zip"
  source_sha256 '9a07e386017dc696573cd7bc7b46b2575c06da0bc68c3c4f1c24a4b39cdedd4d'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'f0d57f404b10ce2dc14a3ce61baa7be9d7bbefc8e0bb77e6b943bf7c07191578',
     armv7l: 'f0d57f404b10ce2dc14a3ce61baa7be9d7bbefc8e0bb77e6b943bf7c07191578',
       i686: '851c65719e952dc8b00c74457002f0f905f75b6bbc64e18a23e2b25b55e0d881',
     x86_64: '921598e9de5c2ac2d22de713bdc4bdeb9d2cd436b4e166f69773c561a2ff53da'
  })

  depends_on 'libpng'
  depends_on 'help2man' => :build

  def self.patch
    system "sed -i 's:CC         = gcc:CC         = #{CREW_TGT}-gcc:' Makefile"
    system "sed -i 's:CFLAGS     = -Wall -pedantic:CFLAGS     = -Wall -pedantic #{CREW_COMMON_FLAGS}:' Makefile"
    system "sed -i 's:CFLAGS_OPT = -O2:CFLAGS_OPT =:' Makefile"
    # zlib is unused, remove the header and library link
    system "sed -i 's:LIBS       = -lstdc++ -lm -lpng -lz:LIBS       = -lstdc++ -lm -lpng:' Makefile"
    system "sed -i 's:#include \"zlib.h\"::' Makefile"
  end

  def self.build
    system 'make'
    system "help2man -s 1 -N -h '' \
            -n '#{description.downcase.delete! '.'}' \
            --version-string='#{version}' \
            ./apng2gif -o apng2gif.1"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'apng2gif', "#{CREW_DEST_PREFIX}/bin/apng2gif", mode: 0o755
    FileUtils.install 'apng2gif.1', "#{CREW_DEST_MAN_PREFIX}/man1/apng2gif.1", mode: 0o644
  end
end
