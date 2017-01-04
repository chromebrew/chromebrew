require 'package'

class Chicken < Package
  version '4.11.0'
  source_url 'https://code.call-cc.org/releases/4.11.0/chicken-4.11.0.tar.gz'
  source_sha1 'b8b1e8b741a5ea5b318c449c3bf8a42f8de8ba69'

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
