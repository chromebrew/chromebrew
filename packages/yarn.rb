require 'package'

class Yarn < Package
  version '0.25.3'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v0.25.3/yarn-v0.25.3.tar.gz'
  source_sha1 'a25d2eba9d40479a795422a23af8db9e950f36d0'

  depends_on 'node'

  def self.build
    system "sudo bash chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
  end

  def self.install
    system "npm install -g"
  end
end
