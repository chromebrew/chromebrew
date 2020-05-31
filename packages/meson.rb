require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.54.0'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.54.0/meson-0.54.0.tar.gz'
  source_sha256 'dde5726d778112acbd4a67bb3633ab2ee75d33d1e879a6283a7b4a44c3363c27'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.54.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.54.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.54.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.54.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e7e4adb627f7496ae4a302f112f25ef3485adbeae59c8fc1e518ff6f4580c96c',
     armv7l: 'e7e4adb627f7496ae4a302f112f25ef3485adbeae59c8fc1e518ff6f4580c96c',
       i686: '1a2afdd2aff04d1aff1130ec3f96c0ae41d06c1567d01cd73cc19b749e8cf4ec',
     x86_64: 'c78da3c1d4d5ea1704f05079bb405fa113ac610ee59ffd87f585601e4113068f',
  })

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
