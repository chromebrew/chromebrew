require 'package'
require_relative 'libxml2'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.11.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.5/libxml2-v2.11.5.tar.bz2'
  source_sha256 'ab3699b697e917c7d5035e81d237a9bc895eb4bf70c0a2259c6d1f125c1b77b6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.5-py3.12_armv7l/py3_libxml2-2.11.5-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.5-py3.12_armv7l/py3_libxml2-2.11.5-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.5-py3.12_i686/py3_libxml2-2.11.5-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.5-py3.12_x86_64/py3_libxml2-2.11.5-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '19b264b7e48bd6d350e96742dc55fc219ad57c1aeab34af444852042d304b266',
     armv7l: '19b264b7e48bd6d350e96742dc55fc219ad57c1aeab34af444852042d304b266',
       i686: '8b6bfcf96537b57ce1c0ae5ccbbf7eb32f68733cce8d94d391e9328d2db35046',
     x86_64: '334c94aa11158a7ea308d3264015edeaf9891e3923783631ba280404097a961e'
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
