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
    aarch64: 'bb5ed6d54ddc9a418a809f0055a08eb99ec745579f17a346e558c1f286d83033',
     armv7l: 'bb5ed6d54ddc9a418a809f0055a08eb99ec745579f17a346e558c1f286d83033',
       i686: 'bc7e5a5e4119c9e234306159553866023bb434956063ae9c49e690ff584cbea5',
     x86_64: '15e91c14b1d7f67f48f0c91b3799dbd0afd93e0dc513e39f25d27672f1cc460f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical

  conflicts_ok # conflicts with replaced perl_locale_messages.
end
