require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.12.3'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.12.3/yarn-v1.12.3.tar.gz'
  source_sha256 '02cd4b589ec22c4bdbd2bc5ebbfd99c5e99b07242ad68a539cb37896b93a24f2'

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
