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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_i686/perl_test_output-1.033-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.36_x86_64/perl_test_output-1.033-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '689a71b93ea01e8aae2c36229196a7106d3d288b8063ec08fb02fe66b7a9fc1f',
  x86_64: '4c40890b5787d4e1abe67a0136e89b8e98237d72272446420029c66dbf90c283'
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
