require 'package'

class Sshfs < Package
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '2.8'
  source_url 'https://github.com/libfuse/sshfs/releases/download/sshfs_2.8/sshfs-2.8.tar.gz'
  source_sha256 '7f689174d02e6b7e2631306fda4fb8e6b4483102d1bce82b3cdafba33369ad22'

  depends_on 'glib'
  depends_on 'fuse'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
