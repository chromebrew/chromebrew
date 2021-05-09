require 'package'

class Perl_stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.3.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz'
  source_sha256 '09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b'

  def self.prebuild
    system 'cpan App::cpanminus'
  end

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_armv7l/perl_stow-2.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_armv7l/perl_stow-2.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_i686/perl_stow-2.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_stow/2.3.1_x86_64/perl_stow-2.3.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '503b01aab3beaf36bd629ab7b8aee2d98e29b780bbc20becdb2e1d0cacdfe150',
     armv7l: '503b01aab3beaf36bd629ab7b8aee2d98e29b780bbc20becdb2e1d0cacdfe150',
       i686: '5a38f30a09b1815beda68dd24ae3ea298183eb40b23b6c455cc990314159d17f',
     x86_64: 'bd129677fb5214d53531b7fde7afd8bc22160e04d55fd05b3c9c1dc8b0c21867'
  })

  def self.prebuild
    system 'cpan App::cpanminus'
  end

  def self.build
    system 'cpanm Test::Output'
    system "./configure #{CREW_OPTIONS} \
      --with-pmdir=$(PERL5LIB= perl -le 'print $INC[0]')"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
