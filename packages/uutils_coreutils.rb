# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.16'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.16_armv7l/uutils_coreutils-0.0.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.16_armv7l/uutils_coreutils-0.0.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.16_i686/uutils_coreutils-0.0.16-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/uutils_coreutils/0.0.16_x86_64/uutils_coreutils-0.0.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '819bf74dc4d1cdbe7fb45cb711b73f2494c14a7779644905a8b50e8bc8739451',
     armv7l: '819bf74dc4d1cdbe7fb45cb711b73f2494c14a7779644905a8b50e8bc8739451',
       i686: '9b6f7f69737350b817fb88ac97f918f8db25ea1418f045446a63783f99c8db7d',
     x86_64: '082a81168509e3c1a0ff43f8f89e82fb46f4e2c2aa89d3dd5a53a16a7317b8a4'
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
