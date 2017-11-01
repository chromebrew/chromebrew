require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.32'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.32.tar.gz'
  source_sha256 '8639dc4d1b21e232285cd483604afc4a6ee810710e00e579dbe9591681722b50'

  binary_url ({
  })
  binary_sha256 ({
  })

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
