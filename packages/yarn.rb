require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.13.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.13.0/yarn-v1.13.0.tar.gz'
  source_sha256 '125d40ebf621ebb08e3f66a618bd2cc5cd77fa317a312900a1ab4360ed38bf14'

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
