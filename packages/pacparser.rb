require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'http://pacparser.manugarg.com/'
  version '1.3.7-1'
  source_url 'https://github.com/pacparser/pacparser/archive/1.3.7.tar.gz'
  source_sha256 '575c5d8096b4c842b2af852bbb8bcfde96170b28b49f33249dbe2057a8beea13'

  def self.build
    system "make -j1 -C src"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} PREFIX=/usr/local make -C src install"
  end
end
