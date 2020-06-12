require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://github.com/libgd/libgd/releases/download/gd-2.3.0/libgd-2.3.0.tar.gz'
  source_sha256 '32590e361a1ea6c93915d2448ab0041792c11bae7b18ee812514fe08b2c6a342'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f08ad9e3eea1b99d9c1528337d1a6fb0e764c35abcc82908acfd8d7635aa5890',
     armv7l: 'f08ad9e3eea1b99d9c1528337d1a6fb0e764c35abcc82908acfd8d7635aa5890',
       i686: 'ae9c98c5282c68e9f1e089281669c9e3e8a02c92a4398bb7725b9fe32ee92a65',
     x86_64: '8e5ade77f722c7e76e8448483d1f6dc9119269173a642368f15fca9322cba14e',
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
