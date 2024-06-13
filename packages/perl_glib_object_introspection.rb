require 'package'

class Perl_glib_object_introspection < Package
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version '0.051-perl5.40'
  license 'GPL PerlArtistic'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.051.tar.gz'
  source_sha256 '6569611dcc80ac1482c7c22264b1ae8c9c351d4983511eb9a6c5f47a10150089'
  binary_compression 'tar.zst'

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'perl_glib' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'gcc_lib' # R

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
