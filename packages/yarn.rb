require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.7.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.7.0/yarn-v1.7.0.tar.gz'
  source_sha256 'e7720ee346b2bd7ec32b7e04517643c38648f5022c7981168321ba1636f2dca3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8879fa67acbd62af27f111ca20f67a746823d21056cac78006675f22fb6f0764',
     armv7l: '8879fa67acbd62af27f111ca20f67a746823d21056cac78006675f22fb6f0764',
       i686: 'fa6eecd4b7fcd9445764e69d4a4ec968c6aecf59a2eee04104a1d181bc87101d',
     x86_64: '2e61b0d2f3c83474e9c8dd7aa1738e6732a9db928164328fd4234908214e86fa',
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
