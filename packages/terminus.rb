require 'package'

class Terminus < Package
  description 'The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform'
  homepage 'https://github.com/pantheon-systems/terminus'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/pantheon-systems/terminus/2.3.0/README.md'
  source_sha256 '52e99c6db48987b1533d7c820ce77e27f416950347964885210bca7d2ac83c19'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/pantheon-systems/terminus/releases/download/#{version}/terminus.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('terminus.phar') ) == 'fda289eb438f1b2a899b17879497d531c5234011e183d09953c8e54a795c6bca'
    system "install -Dm755 terminus.phar #{CREW_DEST_PREFIX}/bin/terminus"
  end
end
