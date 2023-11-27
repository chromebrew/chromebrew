require 'buildsystems/perl'

class Perl_locale_gettext < PErl
  description 'Locale::gettext - message handling functions'
  homepage 'https://search.cpan.org/dist/Locale-gettext/'
  license 'GPL-1+ or Artistic'
  version '1.07-perl5.38.1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38.1_armv7l/perl_locale_gettext-1.07-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38.1_armv7l/perl_locale_gettext-1.07-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38.1_i686/perl_locale_gettext-1.07-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38.1_x86_64/perl_locale_gettext-1.07-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0399157f09775ae6426eb1d3d6af9f80028cafb31afbfa73708864e6a8014704',
     armv7l: '0399157f09775ae6426eb1d3d6af9f80028cafb31afbfa73708864e6a8014704',
       i686: '12cfe45c0532d8e1fa352e12e3568d6277aeb55ec14f72684f7dd4b80c6d23b6',
     x86_64: '57da1a305558f655d1d6d2c322a0000cd8cec298ba431b0113c54c301a9eecbe'
  })

  depends_on 'glibc' # R
end
