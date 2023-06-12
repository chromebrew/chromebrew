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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_armv7l/perl_term_readkey-2.38-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_armv7l/perl_term_readkey-2.38-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_i686/perl_term_readkey-2.38-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.36_x86_64/perl_term_readkey-2.38-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f418eae999f3c02805427d440c478c0d6438cb4dbd47a7b757bca0cc791acea6',
     armv7l: 'f418eae999f3c02805427d440c478c0d6438cb4dbd47a7b757bca0cc791acea6',
       i686: '103535eebcdf38eef22e3cc5befdaaad3518be14ad96ac9b1ff547883509db9c',
     x86_64: 'c989aaceb6b404a437baa31d65a1e60a866611993c58f3fe75223de62ba27b8d'
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
