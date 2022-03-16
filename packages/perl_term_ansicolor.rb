require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://metacpan.org/pod/Term::ANSIColor'
  version '5.01-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RR/RRA/Term-ANSIColor-5.01.tar.gz'
  source_sha256 '6281bd87cced7a885c38aa104498e3cd4b5f4c276087442cf68c67379318f27d'

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
