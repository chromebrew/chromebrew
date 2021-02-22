require 'package'

class Which < Package
  description 'which shows the full path of (shell) commands.'
  homepage 'https://carlowood.github.io/which/'
  version '2.21'
  compatibility 'all'
  source_url 'https://carlowood.github.io/which/which-2.21.tar.gz'
  source_sha256 'f4a245b94124b377d8b49646bf421f9155d36aa7614b6ebf83705d3ffc76eaad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/which-2.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/which-2.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/which-2.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/which-2.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c9f4fc79e47e571c519d63eae22687527028403907f6bc4d2912abe41f96fb2e',
     armv7l: 'c9f4fc79e47e571c519d63eae22687527028403907f6bc4d2912abe41f96fb2e',
       i686: '32deff126b05a282e441171b7a36dbe2de582eb4376ea5496dcbc82e579268f3',
     x86_64: '53d4d8200ed6215ef4eca4ee0ab0b72bd23743046023218b2835971dbf9de30e',
  })

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
