require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.31'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.31.tar.gz'
  source_sha1 'd66f71fb29ec0e9cecbefe9d7433d7a315f3302c'

  def self.build
    system "./configure"
    system "make"
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
