require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.13.0'
  source_url 'https://code.call-cc.org/releases/4.13.0/chicken-4.13.0.tar.gz'
  source_sha256 'add549619a31363d6608b39e0cf0e68b9d5e6ff2a719b5691ddeba57229c6c43'

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
