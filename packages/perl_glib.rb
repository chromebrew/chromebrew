require 'buildsystems/perl'

class Perl_glib < PERL
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version '1.3294-perl5.40'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3294.tar.gz'
  source_sha256 'd715f5a86bcc187075de85e7ae5bc07b0714d6edc196a92da43986efa44e5cbb'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'a4fd5e4b9180a502de77a3225093b3bec875a33dda2fda3bd69ce5b84ddd6a6e',
    aarch64: '3f5e6be19f4e2c4c91badb2bf7c533a7e91faa89682e6326226fb2168ba4a75e',
     armv7l: '3f5e6be19f4e2c4c91badb2bf7c533a7e91faa89682e6326226fb2168ba4a75e',
     x86_64: 'd6bddaf3b90e82e7e4ba064ec14d09e0ba89bac40824b92a59deefb85c7e11fd'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
end
