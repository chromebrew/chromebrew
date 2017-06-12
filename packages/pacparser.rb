require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'http://pacparser.manugarg.com/'
  version '1.3.7'
  source_url 'https://github.com/pacparser/pacparser/archive/1.3.7.tar.gz'
  source_sha1 'bb06b1a0eaeb882877c5afa45cb00b540ee57f5f'

  def self.build
    system "make -C src"
  end

  def self.install
    system "PREFIX=/usr/local make -C src install"
  end
end
