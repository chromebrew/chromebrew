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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-2_armv7l/perl_term_readkey-2.38-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-2_armv7l/perl_term_readkey-2.38-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-2_i686/perl_term_readkey-2.38-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-2_x86_64/perl_term_readkey-2.38-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '41103c448aa3ea3f160fe01189a398a5fd4459d8543caec8ab29a0a01fa444e1',
     armv7l: '41103c448aa3ea3f160fe01189a398a5fd4459d8543caec8ab29a0a01fa444e1',
       i686: 'bc2946c9827d4d986c2fddb906545e2a100540b2548652ba701179ed7052f3ec',
     x86_64: '7aa01f6ee9583f44efdf9fa3ffb9b9defbac3e52082f97d72acc1fc2bb7bd6a9'
  })

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
