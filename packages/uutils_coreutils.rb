# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.18'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.18_armv7l/uutils_coreutils-0.0.18-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.18_armv7l/uutils_coreutils-0.0.18-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.18_i686/uutils_coreutils-0.0.18-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.18_x86_64/uutils_coreutils-0.0.18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '09bf7c9ec7da786615beafa0a6f9fa93963ac845eecfc0a71ed38f8c4e3ad45a',
     armv7l: '09bf7c9ec7da786615beafa0a6f9fa93963ac845eecfc0a71ed38f8c4e3ad45a',
       i686: '75fa951d5ac2fedbb34b07d523e666fde68f8c3161543f93b6cd1ada366b9157',
     x86_64: '931033384608415a641f1dd2590510610fec578b416f711992237b0aa4aa40a1'
  })

  depends_on 'rust' => :build
  depends_on 'sphinx' => :build
  depends_on 'gcc' # R
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
