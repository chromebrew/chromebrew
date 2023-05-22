require 'package'

class Perl_glib < Package
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version '1.3293-perl5.36'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3293.tar.gz'
  source_sha256 '7316a0c1e7cc5cb3db7211214f45d7bdc2354365a680ac4bd3ac8bf06d1cb500'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293_armv7l/perl_glib-1.3293-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293_armv7l/perl_glib-1.3293-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293_i686/perl_glib-1.3293-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293_x86_64/perl_glib-1.3293-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c761c75189294107f3ceddb7daf065fbca3cc3d4ff3e189e514e43b0c53e0abd',
     armv7l: 'c761c75189294107f3ceddb7daf065fbca3cc3d4ff3e189e514e43b0c53e0abd',
       i686: 'dffe05fe906e39a96c4b8b007a2b7239ec7144ef16a5900c774fdac3fa7072dd',
     x86_64: '2e15f22ae728ee3fb06025f4ad53f77b69023da297023a7500d32b80b92dfe30'
  })

  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build

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
