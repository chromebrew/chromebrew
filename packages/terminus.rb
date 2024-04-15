require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.3.5'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/pantheon-systems/terminus/releases/download/3.3.5/terminus.phar'
  source_sha256 'ced00e41f75feaf0def0232ed5fac8aaacd898cb04d0b56bd9664069affbe67c'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
