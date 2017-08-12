require 'package'

class Libpstat < Package
  description 'Library for getting information about running processes'
  homepage 'https://github.com/jcnelson/libpstat'
  version '1.0.0'
  source_url 'https://github.com/flyingP0tat0/libpstat/archive/1.0.0.tar.gz'
  source_sha256 '97c07e1338e0159a6e9d411939d696282c1cbb8134555dbf11d5b38e8c174e07'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
