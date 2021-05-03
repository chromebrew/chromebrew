require 'package'

class Perl_read_key < Package
  description 'Character mode terminal access for Perl Term::ReadKey'
  homepage 'https://metacpan.org/source/JSTOWE/TermReadKey-2.37/'
  version '2.38-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/jonathanstowe/TermReadKey/archive/2.38.tar.gz'
  source_sha256 'bb669c422d7094e19fa85d43676b67933b86d4a1f6b39fed5dbfaaaa97716c1d'

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # conflicts with other perl module installs
    system "find #{CREW_DEST_DIR} -name .packlist -o -name perllocal.pod -delete"
  end
end
