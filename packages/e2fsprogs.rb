require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  @_ver = '1.46.5'
  version @_ver
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{@_ver}/e2fsprogs-#{@_ver}.tar.xz"
  source_sha256 '2f16c9176704cf645dc69d5b15ff704ae722d665df38b2ed3cfc249757d8d81e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.5_armv7l/e2fsprogs-1.46.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.5_armv7l/e2fsprogs-1.46.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.5_i686/e2fsprogs-1.46.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/e2fsprogs/1.46.5_x86_64/e2fsprogs-1.46.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd0ababe4b2faf85050132674cd3cf2b98563c22f5b8775557988a7c0e10f4aaa',
     armv7l: 'd0ababe4b2faf85050132674cd3cf2b98563c22f5b8775557988a7c0e10f4aaa',
       i686: '198b678526aa37a67493bf1d5ea67e710105064519f369eb314129267f7211b0',
     x86_64: 'c0f2abf8ec9388bc2539126557e8e7cfd0e2e9a9f2f8a8a564c2b29212aa84ba'
  })

  depends_on 'glibc' # R
  depends_on 'util_linux' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure #{CREW_OPTIONS}\
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
    # r_corrupt_fs fails on i686
    case ARCH
    when 'x86_64'
      system 'make', 'check'
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-libs'
  end
end
