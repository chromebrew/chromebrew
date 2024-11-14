require 'package'

class Bats < Package
  description 'Bash Automated Testing System'
  homepage 'https://github.com/bats-core/bats-core'
  version '1.11.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/bats-core/bats-core.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1afc15e9cbcc247c6513c904415aaeb4bc44873245ae2b0c8ef78a55fd5ea31',
     armv7l: 'f1afc15e9cbcc247c6513c904415aaeb4bc44873245ae2b0c8ef78a55fd5ea31',
       i686: 'f1ab92897a857020cf0429f2b4d1245345555980816c3db470189f4477c60cc8',
     x86_64: '25ad52e08f98dd338bcdb2e77b32ace2e58533c41046e02da0f65907028ac475'
  })

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX} #{ARCH_LIB}"
  end
end
