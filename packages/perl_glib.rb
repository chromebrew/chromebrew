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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.36_armv7l/perl_glib-1.3293-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.36_armv7l/perl_glib-1.3293-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.36_i686/perl_glib-1.3293-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_glib/1.3293-perl5.36_x86_64/perl_glib-1.3293-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0cf6846578f858302924f7cf2d63b475dbe86ea93dc8869a96e4823f31b40321',
     armv7l: '0cf6846578f858302924f7cf2d63b475dbe86ea93dc8869a96e4823f31b40321',
       i686: 'd07fcde84f93a3e4f6f325d4515b6482342f7d8fb84abadd121571ec2a21a2c5',
     x86_64: '207db96d819ac87be27180c54a44794246dca912ac95a6964f6d8c7af27981bb'
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
