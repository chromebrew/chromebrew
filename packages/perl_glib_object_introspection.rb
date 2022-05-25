require 'package'

class Perl_glib_object_introspection < Package
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version '0.050-perl5.38'
  license 'GPL PerlArtistic'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.050.tar.gz'
  source_sha256 'ecf3bbb824df5eed6a3a7fcfd61be9ef448519801badcc82a6e3c4daab0cd763'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.38_armv7l/perl_glib_object_introspection-0.050-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.38_armv7l/perl_glib_object_introspection-0.050-perl5.38-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.38_x86_64/perl_glib_object_introspection-0.050-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ff44807be2b14ca0b6b6fe54e156e3f2e743ab0a70908ac480e36757c494a684',
     armv7l: 'ff44807be2b14ca0b6b6fe54e156e3f2e743ab0a70908ac480e36757c494a684',
     x86_64: '80f40ca1be2928cc983a349b0c3a9a033600c828427c44104753afbd8a1aaee4'
  })

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
