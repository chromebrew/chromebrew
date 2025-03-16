require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '3.6.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/pantheon-systems/terminus/releases/download/#{version}/terminus.phar"
  source_sha256 '42e192c6ebd8f0e52110f0a6eea173cfed1a7489babceb98fe16d175c3fe3b82'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'terminus.phar', "#{CREW_DEST_PREFIX}/bin/terminus", mode: 0o755
  end
end
