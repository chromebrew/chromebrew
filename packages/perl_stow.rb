require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version "2.4.0-#{CREW_PERL_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.4.0.tar.gz'
  source_sha256 '6fed67cf64deab6d3d9151a43e2c06c95cdfca6a88fab7d416f46a648b1d761d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '365f4071aad89d56e843063820048e763b3ec21bba8ccbe90a9be78f82a3c8eb',
     armv7l: '365f4071aad89d56e843063820048e763b3ec21bba8ccbe90a9be78f82a3c8eb',
       i686: '09bcfda115949403f5114311a8f20726c75a4b27b0e48688979b628876910cde',
     x86_64: '30d36fb6777755f51d1f1aa4f5043e7a11569b023b4d529b3cddd33409cbc317'
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
