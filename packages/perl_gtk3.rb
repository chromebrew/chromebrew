require 'buildsystems/perl'

class Perl_gtk3 < PERL
  description 'Perl interface to the 3.x series of the gtk+ toolkit'
  homepage 'https://metacpan.org/pod/Gtk3'
  version '0.038-perl5.40'
  license 'GPL 2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz'
  source_sha256 '70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc'
  binary_compression 'tar.zst'

  depends_on 'gtk3' # R

  no_compile_needed
end
