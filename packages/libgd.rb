require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.2.4'
  source_url 'https://github.com/libgd/libgd/archive/gd-2.2.4.tar.gz'
  source_sha256 'afdd50db677648cb9335b2dda10dd3a6700d97feb21fe802e6ee0f7065acd8c4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd28375946c7a8a12d8f2d9b95b654336436b0a462e1e5527beb123f559ce1fd0',
     armv7l: 'd28375946c7a8a12d8f2d9b95b654336436b0a462e1e5527beb123f559ce1fd0',
       i686: 'c72309f2dba9663e7d43966d0cf2ac1bcc11202f9bcd5d3a316951dd9273e3e1',
     x86_64: '3615bfbd264818ab623a1ade0fd28339e7ba31ca08c803bcd85040945e219256',
  })

  depends_on 'cmake'
  depends_on 'libpng'

  def self.build
    FileUtils.mkdir('build')
    FileUtils.cd('build') do
      system "cmake -DCMAKE_INCLUDE_PATH=/usr/local/include -DCMAKE_INSTALL_PREFIX=/usr/local .."
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
