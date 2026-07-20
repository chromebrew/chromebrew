require 'buildsystems/perl'

class Perl_cairo < PERL
  description 'Perl interface to the cairo 2d vector graphics library'
  homepage 'https://metacpan.org/pod/Cairo'
  version "1.109-#{CREW_PERL_VER}"
  license 'GPL 2.1'
  compatibility 'x86_64'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.109.tar.gz'
  source_sha256 '8219736e401c2311da5f515775de43fd87e6384b504da36a192f2b217643077f'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '69b350e0ff068fad9a7c757274aa7c0a879cc3360cfc659557c942f347a3d152'
  })

  depends_on 'cairo' => :library
  depends_on 'freetype' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' # R
  depends_on 'perl' => :logical
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
end
