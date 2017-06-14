require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.12.0'
  source_url 'https://code.call-cc.org/releases/4.12.0/chicken-4.12.0.tar.gz'
  source_sha1 'f128b57d42ce6f1d4a56a372916e9e538ae1ceab'

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
