require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version "2.4.1-#{CREW_PERL_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/stow/stow-#{version.split('-')[0]}.tar.gz"
  source_sha256 '2a671e75fc207303bfe86a9a7223169c7669df0a8108ebdf1a7fe8cd2b88780b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8252099e0e33338c65cd3d094e04bb4f549ba6e4ab196984138126672478536a',
     armv7l: '8252099e0e33338c65cd3d094e04bb4f549ba6e4ab196984138126672478536a',
       i686: '49a756bef8ec84432629d2477c2eb42ff418fd6a0cf1a1835d064b5482e61183',
     x86_64: '7e59b61caa1da26a22c8e3662902173d5d88a2837a77b91bf9cb0fab9ece665a'
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
