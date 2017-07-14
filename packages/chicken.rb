require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.12.0'
  source_url 'https://code.call-cc.org/releases/4.12.0/chicken-4.12.0.tar.gz'
  source_sha256 '605ace459bc66e8c5f82abb03d9b1c9ca36f1c2295931d244d03629a947a6989'

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
