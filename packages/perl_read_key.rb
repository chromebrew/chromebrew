require 'package'

class Perl_read_key < Package
  description 'Character mode terminal access for Perl Term::ReadKey'
  homepage 'https://metacpan.org/source/JSTOWE/TermReadKey-2.37/'
  version '2.37'
  compatibility 'all'
  source_url 'https://github.com/jonathanstowe/TermReadKey/archive/v2.37.tar.gz'
  source_sha256 '0fa4fb2f8145e3fb2c2129ad28d55be175abcc258f239ba8ddc2cd83790aa8fb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.37-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.37-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e9628ee71561b0b6b63a5aeffd31d0b128b0cefa989ce5b16a956122aa1f387',
     armv7l: '4e9628ee71561b0b6b63a5aeffd31d0b128b0cefa989ce5b16a956122aa1f387',
       i686: '476c3fb90d238d61040f0a5cdd5c8ffc0ad676327f635fbc851a6b4788b4c149',
     x86_64: '966e8c16894a81003dd29af9c5ceb69d5e2a509c56a8701ff680fe4a2f21868d',
  })

  def self.build
    system "perl", "Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
