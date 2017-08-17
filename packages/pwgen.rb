require 'package'

class Pwgen < Package
  description 'Pwgen is a small, GPL\'ed password generator which creates passwords which can be easily memorized by a human.'
  homepage 'https://sourceforge.net/projects/pwgen/'
  version '2.07'
  source_url 'https://pilotfiber.dl.sourceforge.net/project/pwgen/pwgen/2.07/pwgen-2.07.tar.gz'
  source_sha256 'eb74593f58296c21c71cd07933e070492e9222b79cedf81d1a02ce09c0e11556'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
