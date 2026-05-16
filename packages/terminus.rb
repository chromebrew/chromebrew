require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '4.2.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/pantheon-systems/terminus/releases/download/#{version}/terminus.phar"
  source_sha256 '99ddd221d8e22a34c4d747a19ca3514ca65778b7ed6f858e33dd12c196ae0e74'

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
