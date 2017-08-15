require 'package'

class Sshfs < Package
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '2.8'
  source_url 'https://github.com/libfuse/sshfs/releases/download/sshfs_2.8/sshfs-2.8.tar.gz'
  source_sha256 '7f689174d02e6b7e2631306fda4fb8e6b4483102d1bce82b3cdafba33369ad22'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/sshfs-2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/sshfs-2.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/sshfs-2.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/sshfs-2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4522cda519d6aafed52e9dc327ac212126abd4d0be9abe4bfa35feb286b6b6e4',
     armv7l: '4522cda519d6aafed52e9dc327ac212126abd4d0be9abe4bfa35feb286b6b6e4',
       i686: '7fc2d46cd345c310df8842fceb5d561373c2206e5c53f5be6e0ff27a18d3a6b4',
     x86_64: '355afefdc4f5c8300c7a4c51ddf0f99be2fe57769d7b254f498138b234094feb',
  })

  depends_on 'glib' => :build
  depends_on 'fuse' => :build

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
