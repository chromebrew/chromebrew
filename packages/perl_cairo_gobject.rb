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
     x86_64: '85f72e403784d33104e7d64596553c08763b739449bbdf34560755a7b13144a1'
  })

  depends_on 'cairo' => :library
  depends_on 'freetype' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' # R
  depends_on 'perl' => :logical
  depends_on 'perl_cairo' => :build
  depends_on 'perl_glib' => :build
end
