require 'package'

class Which < Package
  description 'which shows the full path of (shell) commands.'
  homepage 'https://carlowood.github.io/which/'
  version '2.21'
  compatibility 'all'
  source_url 'https://carlowood.github.io/which/which-2.21.tar.gz'
  source_sha256 'f4a245b94124b377d8b49646bf421f9155d36aa7614b6ebf83705d3ffc76eaad'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
