require 'package'

class Ondir < Package
  description 'On Dir is a program that automatically executes scripts as you traverse directories at a terminal.'
  homepage 'https://swapoff.org/ondir.html'
  version '0.2.2'
  source_url 'https://swapoff.org/files/ondir/ondir-0.2.2.tar.gz'
  source_sha256 '475fe7bd447756b4effde87c8aa67e063d805b775785b9f39858422dc244aef2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "CONF=#{CREW_PREFIX}/etc/ondirrc", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm644 ondirrc.eg #{CREW_DEST_PREFIX}/etc/ondirrc.eg"
  end
end
