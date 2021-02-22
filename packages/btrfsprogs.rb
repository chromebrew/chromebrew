require 'package'

class Btrfsprogs < Package
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.wiki.kernel.org/index.php/Main_Page'
  version '5.10.1'
  compatibility 'all'
  source_url 'https://github.com/kdave/btrfs-progs/archive/v5.10.1.tar.gz'
  source_sha256 '69788461f7076951f7235b87d0a5615683151dfbfaaa93f645279bf757e85769'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/btrfsprogs-5.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/btrfsprogs-5.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/btrfsprogs-5.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/btrfsprogs-5.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7219f58137c4275bc242ee4a1c6dc41289a19965e7d4239dc9f0f2d5b917f427',
     armv7l: '7219f58137c4275bc242ee4a1c6dc41289a19965e7d4239dc9f0f2d5b917f427',
       i686: '470bb79df032e2113fe80a37d9d2319f48fdfdee2525b457d74903d2edc7c9de',
     x86_64: '52f7d338e8c1ae27d657ea6e48209fd4517691a15ee39d65b54cf330f26e76af',
  })

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
