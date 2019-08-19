require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.17.3'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.17.3/yarn-v1.17.3.tar.gz'
  source_sha256 'e3835194409f1b3afa1c62ca82f561f1c29d26580c9e220c36866317e043c6f3'

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
