require 'buildsystems/perl'

class Perl_libintl_perl < PERL
  description 'Internationalization library for Perl that aims to be compatible with the Uniforum message translations system as implemented for example in GNU gettext'
  homepage 'https://metacpan.org/dist/libintl-perl'
  version "1.37-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-#{version.split('-').first}.tar.gz"
  source_sha256 'a49b08d56813789e5f03289a3f949459eafe9e40a1a9fc066c42c90009a322cf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a63e1c46b366397c9d186b6af6e7edbe6f09ffbe894e31f617041f0f08fe04f',
     armv7l: '4a63e1c46b366397c9d186b6af6e7edbe6f09ffbe894e31f617041f0f08fe04f',
       i686: 'f74b20b7af70c3a959506db2527449d73c15cfbb58e0dc929b4eb90a80a649e2',
     x86_64: '15e31913bc246941fbc12a112bef57e35eff0b9d2b7111eb0d0c18c500d6aba1'
  })

  depends_on 'glibc' # R
  depends_on 'perl' # R

  conflicts_ok # conflicts with replaced perl_locale_messages.
end
