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

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build

  no_compile_needed
end
