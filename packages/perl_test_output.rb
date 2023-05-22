require 'package'

class Perl_test_output < Package
  description 'Test::Output - Utilities to test STDOUT and STDERR messages.'
  homepage 'https://metacpan.org/pod/Test::Output'
  version '1.033-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Test-Output-1.033.tar.gz'
  source_sha256 'f6a8482740b075fad22aaf4d987d38ef927c6d2b452d4ae0d0bd8f779830556e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033_armv7l/perl_test_output-1.033-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033_armv7l/perl_test_output-1.033-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033_i686/perl_test_output-1.033-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033_x86_64/perl_test_output-1.033-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c599b532a22d1d4e4d634d114f20fa5cb002751e5e135acce91ceeea29aa6849',
     armv7l: 'c599b532a22d1d4e4d634d114f20fa5cb002751e5e135acce91ceeea29aa6849',
       i686: '3555ac1e4fd68659ba84588fa24f47f76b79501fc7d292181f62460b82eba1ac',
     x86_64: 'a98fdc62483cce143ef99ed7f35f6241577580e54448b382a3eb71e6fe42eb3d'
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
