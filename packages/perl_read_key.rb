require 'package'

class Perl_read_key < Package
  description 'Character mode terminal access for Perl Term::ReadKey'
  homepage 'https://metacpan.org/source/JSTOWE/TermReadKey-2.37/'
  version '2.37'
  source_url 'https://github.com/jonathanstowe/TermReadKey/archive/v2.37.tar.gz'
  source_sha256 '0fa4fb2f8145e3fb2c2129ad28d55be175abcc258f239ba8ddc2cd83790aa8fb'

  def self.build
    system "perl", "Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
