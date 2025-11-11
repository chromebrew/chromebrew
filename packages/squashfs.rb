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
    aarch64: 'df94c1a7353d41247a831e3af07fe413be06de0526c513b4a22da846732a7229',
     armv7l: 'df94c1a7353d41247a831e3af07fe413be06de0526c513b4a22da846732a7229',
       i686: 'b68c1afa2efc77ad37c60d49bd87432c3b605aae344eb44c196520bcbc0a6320',
     x86_64: '6b14347f389d05604597759c425364f7a4b00dd0f69c53d11c393bf863d83a78'
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
