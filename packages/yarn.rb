require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '0.27.0-20170629.1443'
  source_url 'https://nightly.yarnpkg.com/yarn-v0.27.0-20170629.1443.tar.gz'
  source_sha256 'e1086d267151cd05896b15023e8c4e253a64e675a80bb38dc294b5b1c86c6656'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'node' unless File.exists? '/usr/local/bin/node'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
  end
end
