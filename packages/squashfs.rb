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
    aarch64: 'fa146db645ee4d4cf3b10f9a7e6425c182fef04505f289378a456e7aba7a373a',
     armv7l: 'fa146db645ee4d4cf3b10f9a7e6425c182fef04505f289378a456e7aba7a373a',
       i686: '51f3a8423f782ce0ee19ede8834deac84aa4161e321df87a397b2b92185395c8',
     x86_64: '861359978b79ed8c8e6d8869b0a7b6c68ead651a627014f45bd9db65c5d58ec6'
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

  def self.build
    FileUtils.cd('squashfs-tools') do
      system "sed -i '5iLZ4_SUPPORT = 1' Makefile"
      system "sed -i '6iLZO_SUPPORT = 1' Makefile"
      system "sed -i '7iXZ_SUPPORT = 1' Makefile"
      system "sed -i '8iZSTD_SUPPORT = 1' Makefile"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('squashfs-tools') do
      FileUtils.install 'mksquashfs',  "#{CREW_DEST_PREFIX}/bin/mksquashfs", mode: 0o755
      FileUtils.install 'unsquashfs',  "#{CREW_DEST_PREFIX}/bin/unsquashfs", mode: 0o755
      FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}man1"
      system "help2man ./mksquashfs -N --no-discard-stderr > #{CREW_DEST_MAN_PREFIX}man1/mksquashfs.1"
      system "help2man ./unsquashfs -N --no-discard-stderr > #{CREW_DEST_MAN_PREFIX}man1/unsquashfs.1"
    end
  end
end
