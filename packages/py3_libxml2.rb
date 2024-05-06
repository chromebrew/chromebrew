require 'package'
require_relative 'libxml2'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.12.6'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.6/libxml2-v2.12.6.tar.bz2'
  source_sha256 '69f08b81d4532d285ceea4cdb017eb2d948cb87c34c1d64248a92be90e84132d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '184d08edd2da472b487106c76f1d1c75dc51a86aedac96e98e1467271212586c',
     armv7l: '184d08edd2da472b487106c76f1d1c75dc51a86aedac96e98e1467271212586c',
       i686: 'ce58730a3847da9c47fed7c8bdb43896f37f87cc6def491bd9713e159e6a23d6',
     x86_64: '2fa962314843cee4a38493dca25bc431b1ce53443063533a127fa7cb4a4dc536'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    Dir.chdir('python') do
      system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir('python') do
      system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
    end
  end
end
