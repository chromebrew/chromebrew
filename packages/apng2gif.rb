require 'package'

class Apng2gif < Package
  description 'Convert APNG animations into animated GIF format.'
  homepage 'https://sourceforge.net/projects/apng2gif/'
  @_ver = '1.8'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/apng2gif/files/#{@_ver}/apng2gif-#{@_ver}-src.zip"
  source_sha256 '9a07e386017dc696573cd7bc7b46b2575c06da0bc68c3c4f1c24a4b39cdedd4d'

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
            -n '#{self.description.downcase.delete! '.'}' \
            --version-string='#{@_ver}' \
            ./apng2gif -o apng2gif.1"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'apng2gif', "#{CREW_DEST_PREFIX}/bin/apng2gif", mode: 0755
    FileUtils.install 'apng2gif.1', "#{CREW_DEST_MAN_PREFIX}/man1/apng2gif.1", mode: 0644
  end
end
