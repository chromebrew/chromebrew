require 'buildsystems/perl'

class Perl_gtk3 < PERL
  description 'Perl interface to the 3.x series of the gtk+ toolkit'
  homepage 'https://metacpan.org/pod/Gtk3'
  version "0.038-#{CREW_PERL_VER}"
  license 'GPL 2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz'
  source_sha256 '70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cde1d94f5e37c7a0d0780025fc3d8f12f662c7092e026dcffeefcbff902b3f11',
     armv7l: 'cde1d94f5e37c7a0d0780025fc3d8f12f662c7092e026dcffeefcbff902b3f11',
     x86_64: '4efda03bf05fc7e550b66e2fea931771de82fc46c44e43da5cdff8d58df5c6e4'
  })

  depends_on 'gtk3' # R
  depends_on 'perl' => :logical
end
