require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'https://e2fsprogs.sourceforge.net/'
  version '1.47.4'
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{version}/e2fsprogs-#{version}.tar.xz"
  source_sha256 'fd5bf388cbdbe006a3d3b318d983b2948382440acc85a87f1e7d108653e8db0b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fc5f306eb85311da4c149c27698af90112dc65ffa15dce34d0227fc833a4e2e',
     armv7l: '6fc5f306eb85311da4c149c27698af90112dc65ffa15dce34d0227fc833a4e2e',
       i686: '3d0e8ac3f57682f35c69e52d3fd905b76e535422c1f87eb3faa5b531846739f6',
     x86_64: 'c158544f1f6202ca7c8e4eaf29fd889527b7e50ef02b38ef54d6160397e2823d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'util_linux' # R

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS}\
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
