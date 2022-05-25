require 'package'

class Perl_test_output < Package
  description 'Test::Output - Utilities to test STDOUT and STDERR messages.'
  homepage 'https://metacpan.org/pod/Test::Output'
  version '1.033-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Test-Output-1.033.tar.gz'
  source_sha256 'f6a8482740b075fad22aaf4d987d38ef927c6d2b452d4ae0d0bd8f779830556e'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.38_armv7l/perl_test_output-1.033-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.38_armv7l/perl_test_output-1.033-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.38_i686/perl_test_output-1.033-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_test_output/1.033-perl5.38_x86_64/perl_test_output-1.033-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '115c9107c77f3aa7d2fecf63ba8fd58c09be8ec2e3e935668c89760fe3cd0016',
     armv7l: '115c9107c77f3aa7d2fecf63ba8fd58c09be8ec2e3e935668c89760fe3cd0016',
       i686: 'c24dc0a817dc8a8c7fb6ef9788029fa9f31bd6b99c630f17891750cfab342621',
     x86_64: 'd465aeea55893d921c4a0b8fe2e9bd0ea9e5ab15abe0f78c5bb208abbb17d778'
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
