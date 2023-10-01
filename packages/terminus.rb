require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.2.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.2.2/terminus.phar'
  source_sha256 'c08370ceb42082c2ed5c4ca7f901fe8e2a40f680a258505536d5c67cdf7c4edb'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
