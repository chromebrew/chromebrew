require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.7.0'
  source_url 'https://github.com/KittyKatt/screenFetch/archive/v3.7.0.tar.gz'
  source_sha1 '5a3702504e154335e372df56e4cb621840dc5506'

  def self.build
  end

  def self.install
    system "install -D screenfetch-dev #{CREW_DEST_DIR}/usr/local/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_DIR}/usr/local/man/man1/screenfetch.1"
  end
end
