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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_armv7l/perl_stow-2.3.1-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_armv7l/perl_stow-2.3.1-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_i686/perl_stow-2.3.1-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1-perl5.36_x86_64/perl_stow-2.3.1-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f96fa99f1b1fba1141631b2c11a05898cc2eb122890bd304ff9ae90f8cdcc32e',
     armv7l: 'f96fa99f1b1fba1141631b2c11a05898cc2eb122890bd304ff9ae90f8cdcc32e',
       i686: 'e7010d9ff0f19fb43950e60151e90af667bc9e439ae5103b0bbd2224bcc181b1',
     x86_64: 'e4f1b06d0a71ea7e5afd8276e36efa881bdc1e42fd8e25ab0dd4540adbbec1b4'
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
