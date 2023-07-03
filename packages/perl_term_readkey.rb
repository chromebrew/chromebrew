require 'package'

class Perl_term_readkey < Package
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38_armv7l/perl_term_readkey-2.38-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38_armv7l/perl_term_readkey-2.38-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38_i686/perl_term_readkey-2.38-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38_x86_64/perl_term_readkey-2.38-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1f610c860e5441959c21e4ca9de7a48f48b16ee7246ce65dbe9c88dd31114c22',
     armv7l: '1f610c860e5441959c21e4ca9de7a48f48b16ee7246ce65dbe9c88dd31114c22',
       i686: 'da6c34ba68c0aa04bba96aae44f05343e2ac8968efe3f8fc119e24f01ad3b21d',
     x86_64: 'aeb52c79f1040056bc4688a7265c1ee3443bdada0b8f357ee4d8db8cfaf2f4cd'
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
