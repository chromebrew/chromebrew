require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'https://github.com/plougher/squashfs-tools'
  version '4.6.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/plougher/squashfs-tools.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.6.1_armv7l/squashfs-4.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.6.1_armv7l/squashfs-4.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.6.1_i686/squashfs-4.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.6.1_x86_64/squashfs-4.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'da924cdb4c4f856b7b9b869e60496b10096132beb2e57592e8f015c1486c123c',
     armv7l: 'da924cdb4c4f856b7b9b869e60496b10096132beb2e57592e8f015c1486c123c',
       i686: 'fbe58537fd0a167f61b60c8c6ea23517c46816ae9e30fdace0f65c72a4887add',
     x86_64: '14309b3d8544314236aacd248f48cb781d28d232b23228646c481e2619223974'
  })

  depends_on 'compressdoc' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'help2man' => :build
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
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
