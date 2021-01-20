require 'package'

class Funny_manpages < Package
  description 'funny unix manpages'
  homepage 'https://github.com/ltworf/funny-manpages'
  version '2.3'
  compatibility 'all'
  source_url 'https://github.com/ltworf/funny-manpages/releases/download/2.3/funny-manpages_2.3.orig.tar.gz'
  source_sha256 'b3459487abf375d0925494f1c015103e2f3198977b68640bb29bc2c3a8f89c83'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv "usr/share/man", "#{CREW_DEST_PREFIX}/share", verbose: true
  end
end
