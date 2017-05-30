require 'package'

class Sshfs < Package
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '2.8'
  source_url 'https://github.com/libfuse/sshfs/releases/download/sshfs_2.8/sshfs-2.8.tar.gz'
  source_sha1 '2b792aa5b3a45e0c3fe65c44bd9da8f64a690830'

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
