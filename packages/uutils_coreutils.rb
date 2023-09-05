# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.21'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.21_armv7l/uutils_coreutils-0.0.21-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.21_armv7l/uutils_coreutils-0.0.21-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.21_i686/uutils_coreutils-0.0.21-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.21_x86_64/uutils_coreutils-0.0.21-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '14dee6002e8ecdba1217569218d2931724c87ef9a4a25d92157c8693734bfb59',
     armv7l: '14dee6002e8ecdba1217569218d2931724c87ef9a4a25d92157c8693734bfb59',
       i686: 'c4b8d9d17d8bd1f6e7365e1933a9458df40ddb42106cc2317f40c7f3efc0c6be',
     x86_64: '5b3793e3704e30e385405237980ad94e1d3dca46d6b4878cdf6bf8542fd13be2'
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
