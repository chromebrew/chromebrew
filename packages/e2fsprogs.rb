require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  @_ver = '1.46.2'
  version @_ver
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{@_ver}/e2fsprogs-#{@_ver}.tar.xz"
  source_sha256 '23aa093295c94e71ef1be490c4004871c5b01d216a8cb4d111fa6c0aac354168'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2_armv7l/e2fsprogs-1.46.2-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2_armv7l/e2fsprogs-1.46.2-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2_i686/e2fsprogs-1.46.2-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2_x86_64/e2fsprogs-1.46.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '63e83f7a4d01967863b2c92c09c72d2f0897ec247a82c72daa7d9b54a3740a64',
    armv7l: '63e83f7a4d01967863b2c92c09c72d2f0897ec247a82c72daa7d9b54a3740a64',
    i686: '1665ca1ac6d19c2505e5ea1730cc5b0d60d5eaf336b4fa4e3dc7986dfb188b53',
    x86_64: '28da7a270ca155feaa91b2cba1c15050cb5e91d1b90283f7f973ad083dc86ff2'
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
     system 'make', 'check'
   end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-libs'
  end
end
