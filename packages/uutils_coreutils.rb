# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'package'

class Uutils_coreutils < Package
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.29'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea976325a82354c44231285aebb75556c0ab6bcc12b76532187126ce2def7340',
     armv7l: 'ea976325a82354c44231285aebb75556c0ab6bcc12b76532187126ce2def7340',
       i686: '867af55fa9831166b3f45a6d2f0f49f29527ef79c1fe729b556bfb8af20f295a',
     x86_64: '59cb8482bd29a74d8c5f34d3f41096b15cab5f9bd26cd3a0b302f7b3cf48379f'
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
