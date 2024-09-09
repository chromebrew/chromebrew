require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.4.0-perl5.40'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.4.0.tar.gz'
  source_sha256 '6fed67cf64deab6d3d9151a43e2c06c95cdfca6a88fab7d416f46a648b1d761d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4be8081576bd9471497a803aa50c664963e473d8eb741a272ff0466cd73357d4',
     armv7l: '4be8081576bd9471497a803aa50c664963e473d8eb741a272ff0466cd73357d4',
       i686: '79e0751809842e9aabf5d419313deb46cd01a1dd9d8230756c39687d459ac85d',
     x86_64: '3c155acfd074f45dbb9b5ca8157ab373d576a023b96038f4c130a40243a1ac10'
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
