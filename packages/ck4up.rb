require 'package'

class Ck4up < Package
  description 'Check for Updates, a utility to monitor web pages for updates'
  homepage 'http://jue.li/crux/ck4up'
  version '1.4'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'http://jue.li/crux/ck4up/ck4up-1.4.tar.gz'
  source_sha256 '37f2f981cfdb6811a906e5520cb27203cb5ecb725d2180aaac59d377c1ac9fbf'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '04faf368ecc2291d8b0177488f1d4d26441dd2e147c27d848c7e1f719eac9238',
     armv7l: '04faf368ecc2291d8b0177488f1d4d26441dd2e147c27d848c7e1f719eac9238',
       i686: '08be206b7492b1517afb7d857b00bf22dbf8443f3dc52cb6b98134bb678483b3',
     x86_64: '5bb33449474861c134b780586c215e8429457312577535502b96c5343a8a0541'
  })

  def self.build; end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts 'A configuration file is required to use ck4up.'.lightblue
    puts 'By default it looks for ~/.ck4up/ck4up.conf'.lightblue
    puts
  end
end
