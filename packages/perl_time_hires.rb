require 'package'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/release/Time-HiRes'
  version '1.9758'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JH/JHI/Time-HiRes-1.9758.tar.gz'
  source_sha256 '5bfa145bc11e70a8e337543b1084a293743a690691b568493455dedf58f34b1e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40c061bbf460cd2f617e94802ed91d3c7a97fc142e4c649ef72160d868e68a94',
     armv7l: '40c061bbf460cd2f617e94802ed91d3c7a97fc142e4c649ef72160d868e68a94',
       i686: 'dd6a1fcab145b5e92ccdec417e61c66beb0f303e0cbc98a5b4ff45cdb0261d09',
     x86_64: '79dfe890436e0e110ae7af0e3905f1aea79b684c63cc751140638eb71e62170a',
  })

  def self.build
    system "perl", "Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
