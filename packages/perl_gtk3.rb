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

  binary_sha256({
    aarch64: '25a4f26be9aeb34661b22d75c895305034bc209f223bd2c55a068ce5ba8f561a',
     armv7l: '25a4f26be9aeb34661b22d75c895305034bc209f223bd2c55a068ce5ba8f561a',
     x86_64: 'ed4008264b2dfce55205b65e0b54a6062bdfd4cc9ab0c8461c339689182a06ed'
  })

  depends_on 'gtk3' # R
end
