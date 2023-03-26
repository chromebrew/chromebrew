require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.1.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.1.4/terminus.phar'
  source_sha256 'a3cd9881eaa563fe4cf1c481f0a94da4f575f486faba9fbffeb063fbaab1dc7b'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
