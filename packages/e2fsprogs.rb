require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  @_ver = '1.46.2'
  version "#{@_ver}-1"
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{@_ver}/e2fsprogs-#{@_ver}.tar.xz"
  source_sha256 '23aa093295c94e71ef1be490c4004871c5b01d216a8cb4d111fa6c0aac354168'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_armv7l/e2fsprogs-1.46.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_armv7l/e2fsprogs-1.46.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_i686/e2fsprogs-1.46.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_x86_64/e2fsprogs-1.46.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '572b1c252242a85862898afa75480a2d6b81352a9deb268e1d01021e2b477045',
     armv7l: '572b1c252242a85862898afa75480a2d6b81352a9deb268e1d01021e2b477045',
       i686: 'e0103e9ecb4e07110909da7405f8ef9a11961a990789a944a0e43271d82aec6b',
     x86_64: 'aa77be21096e0f8f749cc4fc4f2e35d794ba70694a9e4d6b58c49353b5fe9138'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}\
      --enable-elf-shlibs \
      --enable-lto \
      --disable-libblkid \
      --disable-libuuid \
      --disable-uuidd \
      --disable-fsck"
    system 'make'
  end

  def self.check
    # j_recover_fast_commit fails on armv7l
    case ARCH
    when 'i686', 'x86_64'
      system 'make', 'check'
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-libs'
  end
end
