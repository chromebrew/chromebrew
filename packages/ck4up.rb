require 'package'

class Ck4up < Package
  description 'Check for Updates, a utility to monitor web pages for updates'
  homepage 'http://jue.li/crux/ck4up'
  version '1.4'
  source_url 'http://jue.li/crux/ck4up/ck4up-1.4.tar.gz'
  source_sha256 '37f2f981cfdb6811a906e5520cb27203cb5ecb725d2180aaac59d377c1ac9fbf'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "A configuration file is required to use ck4up.".lightblue
    puts "By default it looks for ~/.ck4up/ck4up.conf".lightblue
    puts
  end
end
