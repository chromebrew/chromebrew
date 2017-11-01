require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.2.5'
  source_url 'https://github.com/libgd/libgd/archive/gd-2.2.5.tar.gz'
  source_sha256 '199874fdb006de0911819234104ffa84338e98e82fefbac042a58a3f8272a7df'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake'
  depends_on 'libpng'

  def self.build
    FileUtils.mkdir('build')
    FileUtils.cd('build') do
      system "cmake -DCMAKE_INCLUDE_PATH=#{CREW_PREFIX}/include -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} .."
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
