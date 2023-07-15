# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.20'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.20_armv7l/uutils_coreutils-0.0.20-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.20_armv7l/uutils_coreutils-0.0.20-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.20_i686/uutils_coreutils-0.0.20-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.20_x86_64/uutils_coreutils-0.0.20-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf8f45758d6d67cf77db8baf2757266ef8baf629705d129369387a1931a993ba',
     armv7l: 'bf8f45758d6d67cf77db8baf2757266ef8baf629705d129369387a1931a993ba',
       i686: 'ad26201a5064b9d56df457c22c147e1d34e06db42bf302cc72003d75c612f58a',
     x86_64: '0f292f7d8d285f6becd8cc2de9a2f2c6629c8d7992d9546f5463aa804825d4c5'
  })

  depends_on 'rust' => :build
  depends_on 'sphinx' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with coreutils

  def self.preflight
    %w[coreutils].each do |cutils|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{cutils}.filelist"

      puts "#{cutils} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{cutils} && crew install uutils_coreutils".lightblue
    end
  end

  def self.build
    system 'make PROFILE=release MULTICALL=y'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} MANDIR=#{CREW_MAN_PREFIX} \
      PROFILE=release MULTICALL=y"
  end
end
