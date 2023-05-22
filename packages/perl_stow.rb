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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_i686/perl_stow-2.3.1-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_x86_64/perl_stow-2.3.1-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '5c8866e3e74fa4f28780939839e36e8cc87da2f86d408013de917eb05f732208',
  x86_64: '83674fc98bddd8376f01b9e7e2ee8753af07e6e28a21e17099958f96a01fda34'
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
