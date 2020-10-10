require 'package'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/release/Time-HiRes'
  version '1.9758-1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JH/JHI/Time-HiRes-1.9758.tar.gz'
  source_sha256 '5bfa145bc11e70a8e337543b1084a293743a690691b568493455dedf58f34b1e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_time_hires-1.9758-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '71dfe08892dc8c59a158448050d5d7bd5ea2a4c93adae3304c8645aa612a41e8',
     armv7l: '71dfe08892dc8c59a158448050d5d7bd5ea2a4c93adae3304c8645aa612a41e8',
       i686: '22b74828e23eb8c2a4e3394dbccbe05cd90423f99d3baeaa718dbad011100eef',
     x86_64: 'dd240247cb8051dea6df3af7ea09c45cf16a26790f807139c5a02e9663433ae7',
  })

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
