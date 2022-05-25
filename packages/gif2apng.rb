require 'package'

class Gif2apng < Package
  description 'Convert GIF animations into APNG format.'
  homepage 'https://sourceforge.net/projects/gif2apng/'
  version '1.9'
  license 'ZLIB LGPL-2.1'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/gif2apng/files/#{version}/gif2apng-#{version}-src.zip"
  source_sha256 '3b21308e935d799b3ffb4a86c6e00ffa4cb9b3f72f52d58d51c66eb0574ae7d2'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gif2apng/1.9_armv7l/gif2apng-1.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gif2apng/1.9_armv7l/gif2apng-1.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gif2apng/1.9_i686/gif2apng-1.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gif2apng/1.9_x86_64/gif2apng-1.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c0536e15897691a801c59d4b435c9c6a930bed91ba73a23697c85479284095b7',
     armv7l: 'c0536e15897691a801c59d4b435c9c6a930bed91ba73a23697c85479284095b7',
       i686: '488ade6bcc9b8e1d537937b929a6fa04a8825937fbb779512fc93883d0bea978',
     x86_64: '62ba798c0c56f2df6c00c45b1c7c1e23776175dd7d612333c384ea9c9753a4be'
  })

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
            -n '#{description.downcase.delete! '.'}' \
            --version-string='#{version}' \
            ./gif2apng -o gif2apng.1"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'gif2apng', "#{CREW_DEST_PREFIX}/bin/gif2apng", mode: 0o755
    FileUtils.install 'gif2apng.1', "#{CREW_DEST_MAN_PREFIX}/man1/gif2apng.1", mode: 0o644
  end
end
