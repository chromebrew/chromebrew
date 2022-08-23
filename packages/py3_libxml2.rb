require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version '2.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.0/libxml2-v2.10.0.tar.bz2'
  source_sha256 'c44124d025162767a1d3fe35b556c5855e6be7240e3dc3159490e91d5cadbba3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.0_armv7l/py3_libxml2-2.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.0_armv7l/py3_libxml2-2.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.0_i686/py3_libxml2-2.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.0_x86_64/py3_libxml2-2.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f8a22b53605a67930373f64af313ffe448ccd6596f276b5af257057280f8b445',
     armv7l: 'f8a22b53605a67930373f64af313ffe448ccd6596f276b5af257057280f8b445',
       i686: 'de352c024364b3dc0ca187df68e6e2c397c1886aa13a886938aace1b1e7556ec',
     x86_64: '34f173dbe2b29e9eb1e72e96b6629f92ae0d5cd5da795f3d9915054425f80dff'
  })

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'py3_setuptools' => :build

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
