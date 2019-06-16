require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.2.0'
  source_url 'https://hisham.hm/htop/releases/2.2.0/htop-2.2.0.tar.gz'
  source_sha256 'd9d6826f10ce3887950d709b53ee1d8c1849a70fa38e91d5896ad8cbc6ba3c57'

  depends_on 'buildessential'  => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-unicode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
