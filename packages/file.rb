require 'package'

class File < Package
  version '5.25'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.25.tar.gz'
  source_sha1 'fea78106dd0b7a09a61714cdbe545135563e84bd'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
