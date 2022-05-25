require 'package'

class Samurai < Package
  description 'Samurai is a ninja compatible build tool written in C.'
  homepage 'https://github.com/michaelforney/samurai/'
  @_ver = '1.2'
  version "#{@_ver}-1"
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/michaelforney/samurai.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/samurai/1.2-1_armv7l/samurai-1.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/samurai/1.2-1_armv7l/samurai-1.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/samurai/1.2-1_i686/samurai-1.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/samurai/1.2-1_x86_64/samurai-1.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec57080a9deeee698094cb87f0976168e0dae2ac5685deaf2e68fd1f3d8a7bb3',
     armv7l: 'ec57080a9deeee698094cb87f0976168e0dae2ac5685deaf2e68fd1f3d8a7bb3',
       i686: 'e84c2886040bbc549bb9aebc17fdad87218d4a83371c7f42999dd54b48bde36f',
     x86_64: '292fd418d6db6cd9d2f67a92f1f2fdcbd784f5d4bc5abeee002dbe5f2bd7205d'
  })

  def self.patch
    system "sed -i 's:PREFIX=/usr/local:PREFIX=#{CREW_PREFIX}:' Makefile"
    system "sed -i 's:MANDIR=\$(PREFIX)/share/man:MANDIR=#{CREW_MAN_PREFIX}:g' Makefile"
  end

  def self.build
    system "make CFLAGS='#{CREW_COMMON_FLAGS}' \
                LDFLAGS='#{CREW_LDFLAGS}' \
                CC='#{CREW_TGT}-gcc'"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # no checks
  end
end
