require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.1.3'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.3.tar.gz'
  source_sha256 '55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0'

  depends_on 'buildessential'
  depends_on 'perl' => :build

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
