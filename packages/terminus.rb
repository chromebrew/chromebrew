require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.3.3'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.3.3/terminus.phar'
  source_sha256 '18d5b5ba7c3fcdfa6a48768c3fe5e6c721e1f4ab6a371554359899e297572210'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
