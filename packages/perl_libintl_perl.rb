require 'buildsystems/perl'

class Perl_libintl_perl < PERL
  description 'Internationalization library for Perl that aims to be compatible with the Uniforum message translations system as implemented for example in GNU gettext'
  homepage 'https://metacpan.org/dist/libintl-perl'
  version "1.36-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/gflohr/libintl-perl.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c104b2dd63e7662e4809e45d5c59ffd7f60582d5174bcff90960ca7acc44c272',
     armv7l: 'c104b2dd63e7662e4809e45d5c59ffd7f60582d5174bcff90960ca7acc44c272',
       i686: 'e0ef07730e168d7cb73f27419c7d15ec72d982724f9078093a430835d9824dcd',
     x86_64: '5d07e7cffede716afd6a875ff7af62052bb1ca11aa4e69bcbf0bc12dd87d9ad3'
  })

  depends_on 'glibc' # R
  depends_on 'perl' # R

  conflicts_ok # conflicts with replaced perl_locale_messages.
end
