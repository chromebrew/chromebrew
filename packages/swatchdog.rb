require 'package'

class Swatchdog < Package
  description "swatchdog.pl started out as swatch, the 'simple watchdog' for activity monitoring log files produced by UNIX's syslog facility."
  homepage 'https://sourceforge.net/projects/swatch/'
  version '3.2.4'
  source_url 'https://downloads.sourceforge.net/project/swatch/swatchdog/swatchdog-3.2.4.tar.gz'
  source_sha256 '5bb644d3750ee89b9aecab797df66b28b9fd174a5f0f96cd62367af8975b4f63'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'perl'

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
