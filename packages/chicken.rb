require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '5.1.0'
  source_url 'https://code.call-cc.org/releases/5.1.0/chicken-5.1.0.tar.gz'
  source_sha256 '5c1101a8d8faabfd500ad69101e0c7c8bd826c68970f89c270640470e7b84b4b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'filecmd'

  def self.build
    system "make", "-j1", "PLATFORM=linux" # parallel builds don't work
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
