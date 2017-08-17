require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.31'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.31.tar.gz'
  source_sha256 '09c588dac9cff4baa054f51a36141793bcf64926edc909594111ceae60fce4ee'

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
