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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_armv7l/perl_test_output-1.033-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_armv7l/perl_test_output-1.033-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_i686/perl_test_output-1.033-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_x86_64/perl_test_output-1.033-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ca86085970d3bb5456a613bf7a72c231bac53fe682b5ed9b5de5204c02532946',
     armv7l: 'ca86085970d3bb5456a613bf7a72c231bac53fe682b5ed9b5de5204c02532946',
       i686: '448e6fa7f9e01e2e12e85d2506476c876077860dad9e4c881ba93dfdf008a370',
     x86_64: 'bffa05e9e052824db057080344c3990f6b62196a34914071a7a85ab213959f8a'
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
