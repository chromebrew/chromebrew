require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.1.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.1.2/terminus.phar'
  source_sha256 'bbcbc97f4ccb0a638df24bd35949c406b7e8a4ec456881c6f17b23bd34aeac73'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
