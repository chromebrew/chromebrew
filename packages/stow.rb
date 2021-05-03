require 'package'

class Stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.3.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz'
  source_sha256 '09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b'

  depends_on 'perl'

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
