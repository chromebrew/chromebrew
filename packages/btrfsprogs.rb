require 'package'

class Btrfsprogs < Package
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.wiki.kernel.org/index.php/Main_Page'
  version '5.10.1'
  compatibility 'all'
  source_url 'https://github.com/kdave/btrfs-progs/archive/v5.10.1.tar.gz'
  source_sha256 '69788461f7076951f7235b87d0a5615683151dfbfaaa93f645279bf757e85769'

  depends_on 'util_linux'
  depends_on 'libgcrypt'
  depends_on 'lzo'
# depends_on 'e2fsprogs'

  def self.build
    system "./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
            --disable-documentation \
            --disable-convert \
            --with-crypto=libgcrypt"
#            --with-convert=ext2  # Convert fails to build, help appreciated
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
