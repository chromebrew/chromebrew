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
    aarch64: '001844b85c06c35e270a0dcda592992f7d0b6c2eec1fa761408377aaeb9ceebd',
     armv7l: '001844b85c06c35e270a0dcda592992f7d0b6c2eec1fa761408377aaeb9ceebd',
       i686: 'f025bb6ab3579900e4a035547d377cf25ae31cc7811d50602a9db6894f66833f',
     x86_64: '15e91c14b1d7f67f48f0c91b3799dbd0afd93e0dc513e39f25d27672f1cc460f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libiconv' => :library
  depends_on 'perl' => :logical

  conflicts_ok # conflicts with replaced perl_locale_messages.
end
