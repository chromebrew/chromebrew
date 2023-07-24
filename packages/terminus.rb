require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.2.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.2.1/terminus.phar'
  source_sha256 '9a955d196a1bd63717cc2d6a64170c5d80baa2565fd062a832f2de36e2a82b74'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
