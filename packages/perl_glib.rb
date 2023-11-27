require 'buildsystems/perl'

class Perl_glib < PErl
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version '1.3293-perl5.38.1'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3293.tar.gz'
  source_sha256 '7316a0c1e7cc5cb3db7211214f45d7bdc2354365a680ac4bd3ac8bf06d1cb500'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38.1_armv7l/perl_glib-1.3293-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38.1_armv7l/perl_glib-1.3293-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38.1_i686/perl_glib-1.3293-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38.1_x86_64/perl_glib-1.3293-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a84446e0fe1eaa4427129355a1f73085562a1a9577930262b736df9c13ccb778',
     armv7l: 'a84446e0fe1eaa4427129355a1f73085562a1a9577930262b736df9c13ccb778',
       i686: 'd2c3aab4821acd739c86251b0858a392db5c3372500eeafb8bfc45af06be2d91',
     x86_64: 'd4f4ea6b3c28504abab61889c40cdf3e36b3faa7e1b1e1f2b37f905bc8eb2f57'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
end
