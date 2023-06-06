# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.19'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.19_armv7l/uutils_coreutils-0.0.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.19_armv7l/uutils_coreutils-0.0.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.19_i686/uutils_coreutils-0.0.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.19_x86_64/uutils_coreutils-0.0.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4b96317c1ae050defcd69afec1c4c31d2bd4e06ca0ddca995dde943d8c9948ad',
     armv7l: '4b96317c1ae050defcd69afec1c4c31d2bd4e06ca0ddca995dde943d8c9948ad',
       i686: '8836d6d51560c6b5bc14b08cc46fc34fe0ffe3ad5d0aede3e364fbd24fe004cd',
     x86_64: 'e36a37df7125ae83feae2afc2640c85b06a8628bbdb7e036be679495827163fc'
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
