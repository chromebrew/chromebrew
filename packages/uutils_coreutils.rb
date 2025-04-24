# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.30-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cbb9e498034b5c8fbd2d872f530823839d164855a82f966608f4d4d09877b75',
     armv7l: '7cbb9e498034b5c8fbd2d872f530823839d164855a82f966608f4d4d09877b75',
       i686: 'e44246ac53a63c2df6fea3d5463cb3624cbac69eb4badf6fa274f911551cfcb3',
     x86_64: 'b717177da8e64ef7169b7651b459e04fa0d26b8a729076a66575f6cf521e5d12'
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

  rust_options '--features unix'
  rust_release_profile 'release-fast'
end
