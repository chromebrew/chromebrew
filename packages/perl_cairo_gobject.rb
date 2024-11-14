require 'buildsystems/perl'

class Perl_cairo_gobject < PERL
  description 'Integrate Cairo into the Glib type system'
  homepage 'https://metacpan.org/pod/Cairo::GObject'
  version "1.005-#{CREW_PERL_VER}"
  license 'GPL 2.1'
  compatibility 'x86_64'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-GObject-1.005.tar.gz'
  source_sha256 '8d896444d71e1d0bca3d24e31e5d82bd0d9542aaed91d1fb7eab367bce675c50'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '07a350ad5aafb68a2992c9ec80c3e91360b9533f6926b4fbd963273ab47cbf15'
  })

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'perl_cairo' => :build
  depends_on 'perl_glib' => :build
end
