require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.9.12'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_armv7l/py3_libxml2-2.9.12-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_armv7l/py3_libxml2-2.9.12-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_x86_64/py3_libxml2-2.9.12-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '23a51d55df0b0da57e5dd22271efc40bca272f085c41a47caf7d3b9f31420c81',
     armv7l: '23a51d55df0b0da57e5dd22271efc40bca272f085c41a47caf7d3b9f31420c81',
     x86_64: '110b87135cf67d05d3eb2291db13b2146f15ef9d33096903e61534a5ffcc78b6'
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
