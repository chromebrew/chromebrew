require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '2.5.0'
  compatibility 'all'
  source_url "https://raw.githubusercontent.com/pantheon-systems/terminus/#{version}/README.md"
  source_sha256 '299d011cbd856ba92d22d309efbdb01a3b93bd85eb727512c2bf83eda08dc329'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/pantheon-systems/terminus/releases/download/#{version}/terminus.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('terminus.phar') ) == '71da25da6dc1813d9e3ff129964466e9a14687c2e5ea4e52267f02f28fcc3e27'
    system "install -Dm755 terminus.phar #{CREW_DEST_PREFIX}/bin/terminus"
  end
end
