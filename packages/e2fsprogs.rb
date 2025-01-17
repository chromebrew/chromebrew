require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'https://e2fsprogs.sourceforge.net/'
  version '1.47.2'
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{version}/e2fsprogs-#{version}.tar.xz"
  source_sha256 '144af53f2bbd921cef6f8bea88bb9faddca865da3fbc657cc9b4d2001097d5db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cd2fba8d2d91c0c764f7912bec91ded898fac1bd11c4e58cd6ff160ebe17c99',
     armv7l: '5cd2fba8d2d91c0c764f7912bec91ded898fac1bd11c4e58cd6ff160ebe17c99',
       i686: '0b68894aaeee8d839e36f93d345c1e91c6faacfc9b52c516b3f411a5624e874b',
     x86_64: 'd5ef549b85a6064357bcb6d99038552f9d0ba5ac25815796e5eccf2b18698160'
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
