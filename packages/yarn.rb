require 'package'

class Yarn < Package
  version '0.25.4'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v0.25.3/yarn-v0.25.3.tar.gz'
  source_sha1 '94b08478cf06652a337aef5742cf32472c767924'

  depends_on 'node'

  def self.build
    system "sudo bash chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
  end

  def self.install
    system "npm install -g"
  end
end
