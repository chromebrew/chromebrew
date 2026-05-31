require 'package'

class Github_release < Package
  description 'Commandline app to create and edit releases on Github (and upload artifacts)'
  homepage 'https://github.com/github-release/github-release'
  version '0.11.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/github-release/github-release.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '383252ce685eabad35735b04937d0630985666d79aaeb86aee51e18bd33b5ecf',
     armv7l: '383252ce685eabad35735b04937d0630985666d79aaeb86aee51e18bd33b5ecf',
       i686: 'b39c66a764e5bca4671a29098bd78bb020baa93c8ebfde24def63c0aad2dac7c',
     x86_64: 'd9ddad3199ea93c86e41bb7e9288d13e00a85c1bc212c07ec453929df3062cfb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'github-release', "#{CREW_DEST_PREFIX}/bin/github-release", mode: 0o755
    FileUtils.ln_s "#{CREW_PREFIX}/bin/github-release", "#{CREW_DEST_PREFIX}/bin/gh-release"
  end
end
