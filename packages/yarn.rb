require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.19.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.19.0/yarn-v1.19.0.tar.gz'
  source_sha256 '6bbdaab9c31eedbe7b53cbcde2be06b8c926f139bd0f7c00fccad406016e8934'

  binary_url ({
  })
  binary_sha256 ({
  })

  node_version=`node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
