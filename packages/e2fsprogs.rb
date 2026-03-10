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
    aarch64: 'fa71bdc757bb4bc77fb8c71ab09432ef4c18c6c4e1f46cc9bd8fcbf641ea6278',
     armv7l: 'fa71bdc757bb4bc77fb8c71ab09432ef4c18c6c4e1f46cc9bd8fcbf641ea6278',
       i686: 'd2dee22286152a0209c29b3029c43cb664710a307c673f9ca69b1672b3681250',
     x86_64: 'e2d50995075b6218654c6159bc878ff3dda753e1f9e78250a119d63307dd432c'
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
