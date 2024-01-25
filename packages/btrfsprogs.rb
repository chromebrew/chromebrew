require 'package'

class Btrfsprogs < Package
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.wiki.kernel.org/index.php/Main_Page'
  version '6.1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/kdave/btrfs-progs/archive/v5.10.1.tar.gz'
  source_sha256 '69788461f7076951f7235b87d0a5615683151dfbfaaa93f645279bf757e85769'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30b25d3fa711ffe7a814c779831d81a2330fbfa8d7c755f4e4ae2d7a285a9de2',
     armv7l: '30b25d3fa711ffe7a814c779831d81a2330fbfa8d7c755f4e4ae2d7a285a9de2',
       i686: 'bd46556e6758de9cb7e21e012e81582c65448be3140130b41c24df876886e9b9',
     x86_64: '67b69603e47c96060fbbf3d0e009cd42ed811d345ddad365d82fb41b241b4750'
  })

  depends_on 'e2fsprogs'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'lzo' # R
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} \
            --disable-documentation \
            --disable-convert \
            --with-crypto=libgcrypt \
            --with-convert=ext2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
