require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.9.4'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.9.4/yarn-v1.9.4.tar.gz'
  source_sha256 '7667eb715077b4bad8e2a832e7084e0e6f1ba54d7280dc573c8f7031a7fb093e'

  binary_url ({
  })
  binary_sha256 ({
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
