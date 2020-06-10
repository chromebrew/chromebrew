require 'package'

class Swatchdog < Package
  description "swatchdog.pl started out as swatch, the 'simple watchdog' for activity monitoring log files produced by UNIX's syslog facility."
  homepage 'https://sourceforge.net/projects/swatch/'
  version '3.2.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/swatch/swatchdog/swatchdog-3.2.4.tar.gz'
  source_sha256 '5bb644d3750ee89b9aecab797df66b28b9fd174a5f0f96cd62367af8975b4f63'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '380538365ae9ac2b7a5fa52b27f7c98bf32bc0bd5a9f3982731979d27948eea2',
     armv7l: '380538365ae9ac2b7a5fa52b27f7c98bf32bc0bd5a9f3982731979d27948eea2',
       i686: '6561010781c6bed14fba8aa260e8f179d47a7bf03d17cf82aef4c788748a6ad3',
     x86_64: '8e0dc2bb5643b837bea9f6a68c4316c260590e80ed7610a8d389ff655d4823cf',
  })

  def self.build
    system 'cpan -i File::Tail'
    system 'cpan -i Date::Calc'
    system 'cpan -i Date::Parse'
    system 'cpan -i inc::latest'
    system 'perl Makefile.PL'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
