require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'https://github.com/plougher/squashfs-tools'
  version '4.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/plougher/squashfs-tools.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b76bcefcd9bce133103b5d4c1a875b63b890f67f5b362479c9b3de13252b5643',
     armv7l: 'b76bcefcd9bce133103b5d4c1a875b63b890f67f5b362479c9b3de13252b5643',
       i686: 'b6a2b9d0c60f9b2f9d17bfdd29b8880cae36de3090755d5c09cec14b1f5ef156',
     x86_64: 'ecf589181b60e80d5dbe0edb5b4ffbd01af604f64150378affbd88fbc50823c2'
  })

  depends_on 'compressdoc' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'help2man' => :build
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.patch
    FileUtils.cd('squashfs-tools') do
      system "sed -i '5iLZ4_SUPPORT = 1' Makefile"
      system "sed -i '6iLZO_SUPPORT = 1' Makefile"
      system "sed -i '7iXZ_SUPPORT = 1' Makefile"
      system "sed -i '8iZSTD_SUPPORT = 1' Makefile"
      system "sed -i 's,INSTALL_PREFIX = /usr/local,INSTALL_PREFIX = #{CREW_DEST_PREFIX},g' Makefile"
      system "sed -i 's,INSTALL_MANPAGES_DIR = $(INSTALL_PREFIX)/man/man1,INSTALL_MANPAGES_DIR = #{CREW_DEST_MAN_PREFIX}man1,g' Makefile"
    end
  end

  def self.build
    FileUtils.cd('squashfs-tools') do
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('squashfs-tools') do
      system 'make install'
    end
  end
end
