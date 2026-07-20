require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version "2.4.0-#{CREW_PERL_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/stow/stow-2.4.0.tar.gz'
  source_sha256 '6fed67cf64deab6d3d9151a43e2c06c95cdfca6a88fab7d416f46a648b1d761d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6b4a21448dc4159054c416af691cda857b0c6a39f36f00abc02dab13a253828',
     armv7l: 'd6b4a21448dc4159054c416af691cda857b0c6a39f36f00abc02dab13a253828',
       i686: 'ed86d964fad20958609f2d1021b10539ba759eb2d362b08f4e58d7e6e9c5c594',
     x86_64: '55692990260b2eb77310c96b5d78aed3436f02876116d54a2e9fbc6b137d55de'
  })

  depends_on 'perl_app_cpanminus' => :build

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --with-pmdir=#{CREW_PREFIX}/share/perl5/vendor_perl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
