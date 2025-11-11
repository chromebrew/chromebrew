require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'https://github.com/plougher/squashfs-tools'
  version '4.7.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/plougher/squashfs-tools.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2adc5f6223cd9d3363d0bafd47daa63792ff897cb6ac5750a5bd95233428d041',
     armv7l: '2adc5f6223cd9d3363d0bafd47daa63792ff897cb6ac5750a5bd95233428d041',
       i686: '3023aafdd16f8917c3e94b029d4f4445dc4d9450b1a1288242b16ef74c415d88',
     x86_64: '111f4e5a379f6e28c694c3c6f00e3c92943cc2864eddbebb7457073f99d0e2ed'
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
