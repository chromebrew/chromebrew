require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.12.1'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.12.1/yarn-v1.12.1.tar.gz'
  source_sha256 '09bea8f4ec41e9079fa03093d3b2db7ac5c5331852236d63815f8df42b3ba88d'

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
