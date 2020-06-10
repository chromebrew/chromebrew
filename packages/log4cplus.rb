require 'package'

class Log4cplus < Package
  description 'log4cplus is a simple to use C++ logging API providing thread-safe, flexible, and arbitrarily granular control over log management and configuration.'
  homepage 'https://sourceforge.net/projects/log4cplus/'
  version '1.2.1-rc2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/1.2.1/log4cplus-1.2.1-rc2.tar.xz'
  source_sha256 '44119e4406f22007580fd0c9504cf4c4bf1ed365aef42b177c48267aa1a45178'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/log4cplus-1.2.1-rc2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/log4cplus-1.2.1-rc2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/log4cplus-1.2.1-rc2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/log4cplus-1.2.1-rc2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0951d2e004cc0e4d1f229b6fe488dd352dd7807260c0cbc3a74080e750434b8a',
     armv7l: '0951d2e004cc0e4d1f229b6fe488dd352dd7807260c0cbc3a74080e750434b8a',
       i686: 'b84046cf5bb25cdac7981c8c546d22a3b84004a6ea5f5d823e7e665afdbfbd26',
     x86_64: '55f88fa25c4a676d8ef07cd32228cfcb552b643fc6437a400cbb56e6e358b385',
  })

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
