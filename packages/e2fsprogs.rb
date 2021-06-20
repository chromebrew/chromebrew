require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  @_ver = '1.46.2'
  version @_ver + '-1'
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{@_ver}/e2fsprogs-#{@_ver}.tar.xz"
  source_sha256 '23aa093295c94e71ef1be490c4004871c5b01d216a8cb4d111fa6c0aac354168'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_armv7l/e2fsprogs-1.46.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_armv7l/e2fsprogs-1.46.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_i686/e2fsprogs-1.46.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.2-1_x86_64/e2fsprogs-1.46.2-1-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: '51e6911d87664439b3a2b17f78a379c3a9de7c54e2703caa461a79017bc2e152',
     armv7l: '51e6911d87664439b3a2b17f78a379c3a9de7c54e2703caa461a79017bc2e152',
       i686: 'c26758bca2c3c6cf18668b43f5a4e37f512d5260a90ad7364faee81a1e5bd951',
     x86_64: 'b418edf3a80a54edb3602f67b2a6f1f71b166bfac0e30edfd72829e7e48cbaaa',
  })

  depends_on 'krb5'

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
    # Avoid conflict with files in krb5.
    FileUtils.rm_f Dir["#{CREW_DEST_LIB_PREFIX}/libcom_err.*"]
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/compile_et"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/include/com_err.h"
    FileUtils.rm_f "#{CREW_DEST_MAN_PREFIX}/man1/compile_et.1"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/et/et_c.awk"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/et/et_h.awk"
  end
end
