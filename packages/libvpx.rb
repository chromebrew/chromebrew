require 'package'

class Libvpx < Package
  description 'VP8/VP9 Codec SDK'
  homepage 'http://www.webmproject.org/code/'
  version '1.8.0'
  compatibility 'all'
  source_url 'https://github.com/webmproject/libvpx/archive/v1.8.0.tar.gz'
  source_sha256 '86df18c694e1c06cc8f83d2d816e9270747a0ce6abe316e93a4f4095689373f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvpx-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '33b8d61c591e0f0dfb0770c4ad9227e4a8f8dbf608a68561ad99813063a6934a',
     armv7l: '33b8d61c591e0f0dfb0770c4ad9227e4a8f8dbf608a68561ad99813063a6934a',
       i686: 'afc67c6dbc8c12fa6bd2d7a91e34518119dce03e45e8e8554b4beb670a54b71b',
     x86_64: '9d4aba4937495ec10fe02e6255689280019a30b8db4fbb11826be7c896e1e40c',
  })

  def self.build
    Dir.chdir 'build' do
      system '../configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--enable-vp8',
             '--enable-vp9',
             '--enable-shared',
             '--disable-static'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
