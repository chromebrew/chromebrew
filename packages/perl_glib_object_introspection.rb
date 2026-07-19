require 'buildsystems/perl'

class Perl_glib_object_introspection < PERL
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version "0.051-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.051.tar.gz'
  source_sha256 '6569611dcc80ac1482c7c22264b1ae8c9c351d4983511eb9a6c5f47a10150089'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9435aba36aa00d9940c227a64effa329e03e622c23fed2fc55462efb24b8065c',
     armv7l: '9435aba36aa00d9940c227a64effa329e03e622c23fed2fc55462efb24b8065c',
     x86_64: '3dd1d0e48c718a6311e84e7e75dbdc992a41dfc4a314363e25bcc1771094d40b'
  })

  depends_on 'cairo'
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'libffi' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_glib' => :build
end
