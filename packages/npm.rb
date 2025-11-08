# Adapted from Arch Linux npm PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/npm/trunk/PKGBUILD

require 'package'

class Npm < Package
  description 'A package manager for javascript'
  homepage 'https://www.npmjs.com/'
  version '8.19.2'
  license 'custom:Artistic'
  compatibility 'all'
  source_url 'https://github.com/npm/cli.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '120a61de6f0c4f3f23fe23001a59ad8b0389317c8392c6a96fa4b318f63f5cbb',
     armv7l: '120a61de6f0c4f3f23fe23001a59ad8b0389317c8392c6a96fa4b318f63f5cbb',
       i686: 'a65b7a9e3060ad07b2b6a8455ac7e9c2774f9ccabdac244707030922b284cb33',
     x86_64: 'c60498c73ba31e26aab48ead64a1ad6d537ace0bc6e9fd8f32c6093ca840c2ba'
  })

  depends_on 'nodebrew'

  conflicts_ok # nodebrew

  def self.prebuild
    case ARCH
    when 'i686'
      system 'source ~/.bashrc ; nodebrew install-binary v17.9.1', exception: false
    else
      system 'source ~/.bashrc ; nodebrew install-binary v16.18.1', exception: false
    end
    system 'source ~/.bashrc ; nodebrew use latest'
  end

  def self.build
    system "node . i --ignore-scripts --no-audit --no-fund"
    system "NODE_PATH=#{CREW_LIB_PREFIX}/node_modules make"
  end

  def self.install
    system "node bin/npm-cli.js install -g -f --prefix=#{CREW_DEST_PREFIX} $(node bin/npm-cli.js pack | tail -1)"
    @npmdir = "#{CREW_DEST_LIB_PREFIX}/node_modules/npm"
    system "rm -rf #{@npmdir}/node_modules/{,.bin/}semver"
    system "rm -rf #{@npmdir}/node_modules/{,.bin/}node-gyp"
    system "rm -rf #{@npmdir}/node_modules/{,.bin/}nopt"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    system "node bin/npm-cli.js completion > #{CREW_DEST_PREFIX}/share/bash-completion/completions/npm"
  end
end
