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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_armv7l/perl_text_charwidth-0.04-perl-5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_armv7l/perl_text_charwidth-0.04-perl-5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_i686/perl_text_charwidth-0.04-perl-5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_charwidth/0.04-perl-5.36_x86_64/perl_text_charwidth-0.04-perl-5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '43b5c99fd673e7ac47a11516367505afb89c022b9388706e19d54517436ea7bc',
     armv7l: '43b5c99fd673e7ac47a11516367505afb89c022b9388706e19d54517436ea7bc',
       i686: 'fd86eeb4a6a524e4fe2314fdc4c5e4f454538485526aad1751cc5e175046a528',
     x86_64: '67be1d93589b122d905c9685378fb95eaf5403ac80472481f1baa826c0375571'
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
