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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.049_armv7l/perl_glib_object_introspection-0.049-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.049_armv7l/perl_glib_object_introspection-0.049-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.049_i686/perl_glib_object_introspection-0.049-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib_object_introspection/0.049_x86_64/perl_glib_object_introspection-0.049-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6561437ead57f23fe19cfec0ed0bed957cea36d4bb5005a252477cbd9b1c9ebf',
     armv7l: '6561437ead57f23fe19cfec0ed0bed957cea36d4bb5005a252477cbd9b1c9ebf',
       i686: 'cd54ffc5b6ca9ac3dc47b55c989c755b339fa5326d015b1bc74bba4981aaeab2',
     x86_64: '32ee1a5dd7125d28f250cecca2b3655e379e88c0124efea7333c146d07e3702d'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'perl_glib' => :build

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
