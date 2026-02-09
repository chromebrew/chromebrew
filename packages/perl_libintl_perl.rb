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
    aarch64: '53faaa6391ee0964ee495c8adbf1532c065d039a895b716cb9d69a80de0e3243',
     armv7l: '53faaa6391ee0964ee495c8adbf1532c065d039a895b716cb9d69a80de0e3243',
       i686: '561ed846639f73f5470163be715ea7e2e2de90f67a918c8d2999426218775ccf',
     x86_64: '496889e426f4c1f0aba3b726cf0c8508a476fe19f2052274ad217a54efbc2ad7'
  })

  depends_on 'glibc' # R
  depends_on 'perl' # R

  conflicts_ok # conflicts with replaced perl_locale_messages.
end
