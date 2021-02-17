require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  @_ver = '0.57.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/mesonbuild/meson/archive/#{@_ver}.tar.gz"
  source_sha256 'fd26a27c1a509240c668ebd29d280649d9239cf8684ead51d5cb499d1e1188bd'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.57.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '956b43e32f94d860cf43773a7a80634f0e7c09febc150518cb6419265b5d7e33',
     armv7l: '956b43e32f94d860cf43773a7a80634f0e7c09febc150518cb6419265b5d7e33',
       i686: '1b7d8082b8930f302c43e07404b13accabcdf29f0c3bc9e5abba07876a1e8b57',
     x86_64: 'cafa9cb7cbd2473e1f22abe2f93b8f7ffe9816834a62b4e4810ec21565153571'
  })

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
