require 'package'

class Filecmd < Package
  version '5.29'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.29.tar.gz'
  source_sha1 '8d360aeed901e3e4f4d4a865696ac1e29efdfcca'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
