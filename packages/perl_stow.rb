require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.3.1-perl5.36'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz'
  source_sha256 '09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_armv7l/perl_stow-2.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_armv7l/perl_stow-2.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_i686/perl_stow-2.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_x86_64/perl_stow-2.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c72e956c2871eb63497a181baaafa6e83d9e1778179b23d990c48a9fc0299a5e',
     armv7l: 'c72e956c2871eb63497a181baaafa6e83d9e1778179b23d990c48a9fc0299a5e',
       i686: 'ece16431913257aef01c0b4b95a8872f9c215099bac4f2975648974d836d333c',
     x86_64: 'eb73e9e9a2084abb31fc08e9b4ff80e145fc94ee7f3e2a034d74af18c721c16f'
  })

  depends_on 'perl_app_cpanminus' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-pmdir=#{CREW_PREFIX}/share/perl5/vendor_perl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
