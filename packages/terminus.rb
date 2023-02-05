require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.1.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.1.3/terminus.phar'
  source_sha256 'e9c2be872753b6d4adbaefde44082ca817b97bb04f934053991d92f113a1a647'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
