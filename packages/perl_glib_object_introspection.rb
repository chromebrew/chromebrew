require 'buildsystems/perl'

class Perl_glib_object_introspection < PERL
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version "0.052-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-#{version.split('-')[0]}.tar.gz"
  source_sha256 '555b4f1308939bb3141ea4570ad12e04e27c23329c302c9dc8725409e1049111'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca6a0a632deb4ae701cb8160f9dfe6637084c7ad0829dbccb1db01da0e23f47f',
     armv7l: 'ca6a0a632deb4ae701cb8160f9dfe6637084c7ad0829dbccb1db01da0e23f47f',
     x86_64: '1b64252654cbd3e55cc343f0ded1c8b16ed82bf252e643e22dad9511a2a9d2c4'
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
