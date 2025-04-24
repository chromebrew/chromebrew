# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/RUST'

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
    aarch64: '6affd6acc08b60663ad2b6f5a2b8748ac775182ff19d38b34dc82b37ee094dcf',
     armv7l: '6affd6acc08b60663ad2b6f5a2b8748ac775182ff19d38b34dc82b37ee094dcf',
       i686: 'd2501dee6e01b2fd0fd9384b858bd2b54c0f687bbe0752223850c9a5bc33c147',
     x86_64: 'fc0d3d4894213619d5044bc09d9e2e5684a59c560a466fe1e59024e3df610cbd'
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
