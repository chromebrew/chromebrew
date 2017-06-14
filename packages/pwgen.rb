require 'package'

class Pwgen < Package
  description 'Pwgen is a small, GPL\'ed password generator which creates passwords which can be easily memorized by a human.'
  homepage 'https://sourceforge.net/projects/pwgen/'
  version '2.07'
  source_url 'https://pilotfiber.dl.sourceforge.net/project/pwgen/pwgen/2.07/pwgen-2.07.tar.gz'
  source_sha1 '51180f9cd5530d79eea18b2443780dec4ec5ea43'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
