require 'buildsystems/perl'

class Perl_glib < PERL
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version "1.3294-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3294.tar.gz'
  source_sha256 'd715f5a86bcc187075de85e7ae5bc07b0714d6edc196a92da43986efa44e5cbb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01a3ccd12e0fe4ccb074140013c5b6bf91ed1746ccafc40d50790bc0194a10fa',
     armv7l: '01a3ccd12e0fe4ccb074140013c5b6bf91ed1746ccafc40d50790bc0194a10fa',
       i686: '93e33c00c6fa17f08d1adc7cd2fdaba63274aa5bca98fafa1e61b20b32dbbb05',
     x86_64: 'f7ee55234458aef6199911df7ebbf59dadae2d2d77376eea284ad83e2196d7a1'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
end
