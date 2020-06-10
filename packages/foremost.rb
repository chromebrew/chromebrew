require 'package'

class Foremost < Package
  description 'Foremost is a console program to recover files based on their headers, footers, and internal data structures.'
  homepage 'http://foremost.sourceforge.net/'
  version '1.5.7'
  compatibility 'all'
  source_url 'http://foremost.sourceforge.net/pkg/foremost-1.5.7.tar.gz'
  source_sha256 '502054ef212e3d90b292e99c7f7ac91f89f024720cd5a7e7680c3d1901ef5f34'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/foremost-1.5.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/foremost-1.5.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/foremost-1.5.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/foremost-1.5.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45ee9afccc2ac3fc0c3b9e788a8f7f4cc5cd8b3a4cb10fed415e6f5f4c7fa59b',
     armv7l: '45ee9afccc2ac3fc0c3b9e788a8f7f4cc5cd8b3a4cb10fed415e6f5f4c7fa59b',
       i686: '69180049e0316e97efe0830a9b25c7e1cc68e55cfe193e06fffa101d7f451c09',
     x86_64: '541f63cd095bd5ba0ace2c7943de31c341fa2419ca7ea7b4b7ed1058f17c6039',
  })

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", \
                       "#{CREW_DEST_PREFIX}/man/man1", \
                       "#{CREW_DEST_PREFIX}/etc"]
    FileUtils.cp_r 'foremost', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp_r 'foremost.8.gz', "#{CREW_DEST_PREFIX}/man/man1/foremost.1.gz"
    FileUtils.cp_r 'foremost.conf', "#{CREW_DEST_PREFIX}/etc/"
  end
end
