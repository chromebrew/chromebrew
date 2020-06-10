require 'package'

class Moc < Package
  description 'music on console'
  homepage 'http://moc.daper.net/'
  version '2.5.2'
  compatibility 'all'
  source_url 'http://ftp.daper.net/pub/soft/moc/stable/moc-2.5.2.tar.bz2'
  source_sha256 'f3a68115602a4788b7cfa9bbe9397a9d5e24c68cb61a57695d1c2c3ecf49db08'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/moc-2.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/moc-2.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/moc-2.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/moc-2.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd25d8ee963c5a4dc02b01d432ad69dfdea09f2ab05fa78da0d0e1fcf5fbc96d',
     armv7l: 'fd25d8ee963c5a4dc02b01d432ad69dfdea09f2ab05fa78da0d0e1fcf5fbc96d',
       i686: '08101077400e2ff57ba6b9b37fce21e9f460511a610bd90fb818c633b70cecf1',
     x86_64: '9103ec69198179f32c47efbf422bad69c81621c789c6018279fa1b1e130c4ec6',
  })

  depends_on 'flac'
  depends_on 'libdb'
  depends_on 'libmad'
  depends_on 'libid3tag'
  depends_on 'libsndfile'
  depends_on 'libvorbis'
  depends_on 'popt'
  depends_on 'speex'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-debug'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
