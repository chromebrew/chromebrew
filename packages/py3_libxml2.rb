require 'package'
require_relative 'libxml2'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.12.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.5/libxml2-v2.12.5.tar.bz2'
  source_sha256 '6ac1511e1f659940708254c430b51a7ba6b88a8d1d46b03e5a1e0e264bd87679'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6f747a81d1a7aff9b958373d642911f94e423840e02041570b077fa3bf879e9',
     armv7l: 'd6f747a81d1a7aff9b958373d642911f94e423840e02041570b077fa3bf879e9',
       i686: '66c629606887a495e8a1e9bfa5c2b6a7aa757baa27cae07ca669bfb31adc1ccf',
     x86_64: '222da927a2495bd9e3ae7db94b8f2b37d1dab885c1fa1551102e8383ee05e5d8'
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
