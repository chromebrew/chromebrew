require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.10.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.10.0/yarn-v1.10.0.tar.gz'
  source_sha256 '83277bd505c7f4009c13077266020c97298727de7edf67af5ca66eccae9d4632'

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
