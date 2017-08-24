require 'package'

class Sshfs < Package
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '2.10'
  source_url 'https://github.com/libfuse/sshfs/releases/download/sshfs-2.10/sshfs-2.10.tar.gz'
  source_sha256 '70845dde2d70606aa207db5edfe878e266f9c193f1956dd10ba1b7e9a3c8d101'

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
