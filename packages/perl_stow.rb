require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.3.1-perl5.38'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz'
  source_sha256 '09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.38_armv7l/perl_stow-2.3.1-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.38_armv7l/perl_stow-2.3.1-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.38_i686/perl_stow-2.3.1-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.38_x86_64/perl_stow-2.3.1-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'baadb8bcc4c4d87fcd9b336568c46dee7bc6310f0a9371bd5b54f70586fce417',
     armv7l: 'baadb8bcc4c4d87fcd9b336568c46dee7bc6310f0a9371bd5b54f70586fce417',
       i686: '4cf1c9bbad4fffc4f6a144065f8822a72d7f1b57618c682771918eee4303bf65',
     x86_64: '79689d5ce48d3454071d3ce93838b57b2e10094989022e15e643de9362084e4a'
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
