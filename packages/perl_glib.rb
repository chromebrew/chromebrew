require 'buildsystems/perl'

class Perl_glib < PERL
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version '1.3293-perl5.38.2'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3293.tar.gz'
  source_sha256 '7316a0c1e7cc5cb3db7211214f45d7bdc2354365a680ac4bd3ac8bf06d1cb500'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee1b9f541b3cf0476ccef89bddee302490510b124ac4c33ae7d26954fea73966',
     armv7l: 'ee1b9f541b3cf0476ccef89bddee302490510b124ac4c33ae7d26954fea73966',
       i686: '9336cb1994c3d7e676e7129dff13b49b2305ffb0a91452b7cad871c51e6ac5aa',
     x86_64: 'ee4a1490efaae3cccf58f98547b631e41f78a104de83d3cec088b4d30090a719'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
end
