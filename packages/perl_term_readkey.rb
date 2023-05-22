require 'package'

class Perl_term_readkey < Package
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_i686/perl_term_readkey-2.38-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_x86_64/perl_term_readkey-2.38-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'ddaec2057ef5f4282dc7fe69115f462f051083b80340a5ea42baeab30a07f7a2',
  x86_64: 'f29c2299108b54a7d66dd0eeb0a9ea527ba49907e3eb6eb3c7591fae940b4b0f'
  })

  depends_on 'glibc' # R

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
