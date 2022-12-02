require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.10.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.3/libxml2-v2.10.3.tar.bz2'
  source_sha256 '302bbb86400b8505bebfbf7b3d1986e9aa05073198979f258eed4be481ff5f83'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.3-py3.11_armv7l/py3_libxml2-2.10.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.3-py3.11_armv7l/py3_libxml2-2.10.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.3-py3.11_i686/py3_libxml2-2.10.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.3-py3.11_x86_64/py3_libxml2-2.10.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '09be87f83073941a30c4653c4e364fe919d5a23417d14e84942a97ce0e484fde',
     armv7l: '09be87f83073941a30c4653c4e364fe919d5a23417d14e84942a97ce0e484fde',
       i686: '008663242f5709f9b04cd1f3b444a7b2c48862dd032da0399dcbd7b1ccad738a',
     x86_64: '993ad6b79abe840dbc544f6ee4c7b25e9632101c42071a3dfb24039a65cc3dae'
  })

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'py3_setuptools' => :build
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
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
