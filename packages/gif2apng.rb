require 'package'

class Gif2apng < Package
  description 'Convert GIF animations into APNG format.'
  homepage 'https://sourceforge.net/projects/gif2apng/'
  @_ver = '1.9'
  version @_ver
  license 'ZLIB LGPL-2.1'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/gif2apng/files/#{@_ver}/gif2apng-#{@_ver}-src.zip"
  source_sha256 '3b21308e935d799b3ffb4a86c6e00ffa4cb9b3f72f52d58d51c66eb0574ae7d2'

  depends_on 'zopfli'
  depends_on 'help2man' => :build

  def self.patch
    system "sed -i 's:CC         = gcc:CC         = #{CREW_TGT}-gcc:' Makefile"
    system "sed -i 's:CFLAGS     = -Wall -pedantic:CFLAGS     = -Wall -pedantic #{CREW_COMMON_FLAGS}:' Makefile"
    system "sed -i 's:CFLAGS_OPT = -O2:CFLAGS_OPT =:' Makefile"
    # use system zopfli
    system "sed -i 's:SRC_DIRS   = . 7z zopfli:SRC_DIRS   = . 7z:' Makefile"
    system "sed -i 's:LIBS       = -lstdc++ -lm -lz:LIBS       = -lstdc++ -lm -lz -lzopfli:' Makefile"
  end

  def self.build
    system 'make'
    system "help2man -s 1 -N -h '' \
            -n '#{self.description.downcase.delete! '.'}' \
            --version-string='#{@_ver}' \
            ./gif2apng -o gif2apng.1"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'gif2apng', "#{CREW_DEST_PREFIX}/bin/gif2apng", mode: 0755
    FileUtils.install 'gif2apng.1', "#{CREW_DEST_MAN_PREFIX}/man1/gif2apng.1", mode: 0644
  end
end
