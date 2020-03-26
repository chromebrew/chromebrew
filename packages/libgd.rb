require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.3.0'
  source_url 'https://github.com/libgd/libgd/releases/download/gd-2.3.0/libgd-2.3.0.tar.gz'
  source_sha256 '32590e361a1ea6c93915d2448ab0041792c11bae7b18ee812514fe08b2c6a342'

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
