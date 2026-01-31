require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '4.1.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/pantheon-systems/terminus/releases/download/#{version}/terminus.phar"
  source_sha256 '84d0cdc308b4810c85c75d959bc18c71fa1279b371a2e32384ff2d63292d9538'

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
