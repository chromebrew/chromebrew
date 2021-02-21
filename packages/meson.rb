require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  @_ver = '0.57.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/mesonbuild/meson/archive/#{@_ver}.tar.gz"
  source_sha256 '0c043c9b5350e9087cd4f6becf6c0d10b1d618ca3f919e0dcca2cdf342360d5d'

  depends_on 'ninja'
  
  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '585c785818f5d827ad42460f2b399e512fe2a0fb8141e8999332574adb9e92c9',
     armv7l: '585c785818f5d827ad42460f2b399e512fe2a0fb8141e8999332574adb9e92c9',
       i686: '911a3635a816a1f32a446992ab35b491b5eafdf9841568b12c97d52ecdc80e9c',
     x86_64: 'afee9de7a49e6087878e154de18b48e6ac4c2d5b50e13a56034a63892baf7187'
  })

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
