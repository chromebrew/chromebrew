require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'https://github.com/plougher/squashfs-tools'
  version '4.7.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/plougher/squashfs-tools.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fd4f0eff882a2e3317654aee986074a2f14ddafcfb606c756806aa24dffb55c',
     armv7l: '4fd4f0eff882a2e3317654aee986074a2f14ddafcfb606c756806aa24dffb55c',
       i686: 'd08efb8eca9d291be96d81d4d68d60e026bbfc7ec2b5805aef22036171c549f8',
     x86_64: '04cfc48509ad2f8e61e8ed733367665df3de6cca7cc4a2aa5a2648a5e317522d'
  })

  depends_on 'compressdoc' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'help2man' => :build
  depends_on 'lz4' => :executable
  depends_on 'lzo' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

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
