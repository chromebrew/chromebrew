require 'package'

class Perl_glib_object_introspection < Package
  description 'Dynamically create Perl language bindings'
  homepage 'https://metacpan.org/pod/Glib::Object::Introspection'
  version '0.050-perl5.36'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.050.tar.gz'
  source_sha256 'ecf3bbb824df5eed6a3a7fcfd61be9ef448519801badcc82a6e3c4daab0cd763'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.36_armv7l/perl_glib_object_introspection-0.050-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.36_armv7l/perl_glib_object_introspection-0.050-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.36_i686/perl_glib_object_introspection-0.050-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.050-perl5.36_x86_64/perl_glib_object_introspection-0.050-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0d8fb2b82127c640bc82bab87e59489b430578280665059da6e63b9ae1cf829b',
     armv7l: '0d8fb2b82127c640bc82bab87e59489b430578280665059da6e63b9ae1cf829b',
       i686: '30c316c308cf3fb8991cb95fd9668ff23ffd72d853d47d95e500c80ab963cd5a',
     x86_64: 'a9ed8bb8a84827551d456ae860ac2918f59b794712e383bda48835ff3f3c1b3d'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'perl_glib' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R

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
