require 'package'

class Perl_glib < Package
  description 'Provides perl access to Glib and GLib\'s GObject libraries.'
  homepage 'https://metacpan.org/pod/Glib'
  version '1.3293-perl5.38'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.3293.tar.gz'
  source_sha256 '7316a0c1e7cc5cb3db7211214f45d7bdc2354365a680ac4bd3ac8bf06d1cb500'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38_armv7l/perl_glib-1.3293-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38_armv7l/perl_glib-1.3293-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38_i686/perl_glib-1.3293-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.38_x86_64/perl_glib-1.3293-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'eb9e1bb3ca4de98de775fe0d2c0f1e0b39e965d41da0f12fb5ad7d85bc881c94',
     armv7l: 'eb9e1bb3ca4de98de775fe0d2c0f1e0b39e965d41da0f12fb5ad7d85bc881c94',
       i686: 'e27c57b1cf424a6fc5e5f88d210e7d24e8c67dc6691974b9f760978b35d74221',
     x86_64: '07c65fa1971747ddfaa779f6a7ea13dc048916185c971fc216bd3f1e3e2ca3fa'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
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
