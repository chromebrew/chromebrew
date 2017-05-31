require 'package'

class Dstat < Package
  description 'Dstat is a versatile replacement for vmstat, iostat, netstat and ifstat.'
  homepage 'http://dag.wiee.rs/home-made/dstat/'
  version '0.7.3'
  source_url 'https://github.com/dagwieers/dstat/archive/0.7.3.tar.gz'
  source_sha1 '1e410412a1f53b7be5292354e815785f480fd0e5'

  depends_on "python27"

  def self.build
  end

  def self.install
    system "make", "prefix=/usr/local", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
