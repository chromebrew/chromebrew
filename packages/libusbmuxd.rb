require 'package'

class Libusbmuxd < Package
  description 'USB Multiplex Daemon'
  homepage 'http://www.libimobiledevice.org/'
  version '2.0.1'
  source_url 'https://github.com/libimobiledevice/libusbmuxd/archive/2.0.1.tar.gz'
  source_sha256 'f93faf3b3a73e283646f4d62b3421aeccf58142266b0eb22b2b13dd4b2362eb8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libusbmuxd-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9db036100d9e97fbeb94a88545fab317f4c38d4e642ba668e30183d230906654',
     armv7l: '9db036100d9e97fbeb94a88545fab317f4c38d4e642ba668e30183d230906654',
       i686: '8ab3386d2ad4347f58e48a47333f0e759b9ebd54eec99b435f8ae4a1e953cad4',
     x86_64: '6aab88193820ba3b336c083147c0a5ac449a3ebb839d726144454e89ee0ecb80',
  })

  depends_on 'glib'
  depends_on 'libplist'

  def self.build
    system "./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
