require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_i686/perl_text_charwidth-0.04-perl-5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_x86_64/perl_text_charwidth-0.04-perl-5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'a0dd49e8edbc26e54f34fc3d57130a6eea0ebff73a668221e05ed8e8cec489e6',
  x86_64: 'd21101abb3d966bea235fd05a4b96da73585bcd7f35fcbe098946f84195227c4'
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
