require 'buildsystems/perl'

class Perl_glib_object_introspection < PERL
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version '0.051-perl5.40'
  license 'GPL PerlArtistic'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.051.tar.gz'
  source_sha256 '6569611dcc80ac1482c7c22264b1ae8c9c351d4983511eb9a6c5f47a10150089'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7193ab962dd8e2c414c8f0de9828e4ff072d16ee90682523949a32b33e3273d9',
     armv7l: '7193ab962dd8e2c414c8f0de9828e4ff072d16ee90682523949a32b33e3273d9',
     x86_64: '164f404f95c34e34a085bb115685832c2a24e3c406a5fc0dadabd79821079830'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'perl_glib' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'gcc_lib' # R
end
