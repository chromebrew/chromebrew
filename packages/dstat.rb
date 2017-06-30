require 'package'

class Dstat < Package
  description 'Dstat is a versatile replacement for vmstat, iostat, netstat and ifstat.'
  homepage 'http://dag.wiee.rs/home-made/dstat/'
  version '0.7.3'
  source_url 'https://github.com/dagwieers/dstat/archive/0.7.3.tar.gz'
  source_sha256 '46e63821857b69fbc60cb2c7d893ccdd6f31cd9ef24b8bb0b68951e1c7374898'

  depends_on "python27"

  def self.build
  end

  def self.install
    system "make", "prefix=/usr/local", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
