require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.57.1-1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/mesonbuild/meson/archive/#{@_ver}.tar.gz"
  source_sha256 '0c043c9b5350e9087cd4f6becf6c0d10b1d618ca3f919e0dcca2cdf342360d5d'

  depends_on 'ninja'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
