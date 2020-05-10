require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.2.0'
  compatibility 'all'
  source_url 'https://hisham.hm/htop/releases/2.2.0/htop-2.2.0.tar.gz'
  source_sha256 'd9d6826f10ce3887950d709b53ee1d8c1849a70fa38e91d5896ad8cbc6ba3c57'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3d6c1ed809d819222a7d1f9f2b406df0a2c6caf6175870133d5538099c038d74',
     armv7l: '3d6c1ed809d819222a7d1f9f2b406df0a2c6caf6175870133d5538099c038d74',
       i686: 'b2442db4e63ea03b73cae57ccb48f62cfc05e599ee55790b63fe762915df1042',
     x86_64: 'fec8aed1ed6dc3b232bb23b07f06401bbc991636d67bb291bbb4e6604a9f8229',
  })

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
