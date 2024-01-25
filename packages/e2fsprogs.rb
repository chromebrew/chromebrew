require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  version '1.47.0'
  license 'GPL-2 and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{version}/e2fsprogs-#{version}.tar.xz"
  source_sha256 '144af53f2bbd921cef6f8bea88bb9faddca865da3fbc657cc9b4d2001097d5db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51792a67015212b0bc3c88234a78b051ef7ee3e560afe9b40f4fde00843d48a1',
     armv7l: '51792a67015212b0bc3c88234a78b051ef7ee3e560afe9b40f4fde00843d48a1',
       i686: 'c60055a9bf3971add38d3ca04414489f578de426e1037cb0bdd5c7861f12eb9d',
     x86_64: 'a266108352a3ef02d4a8b245962ca27ea8eb19adb983abb90138d86dbe02e6df'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'util_linux' # R

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
