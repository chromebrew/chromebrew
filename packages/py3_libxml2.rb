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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_i686/py3_libxml2-2.9.12-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_x86_64/py3_libxml2-2.9.12-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2bee7439421a391a1f43595d9d840d90b5ca88d0c863655b5e6cff1b9888c616',
     armv7l: '2bee7439421a391a1f43595d9d840d90b5ca88d0c863655b5e6cff1b9888c616',
       i686: '04a9be201cb9309b0718663f6988aa412cf97c0f7c672332f53031aab5d310d9',
     x86_64: '4e428d28cb7445a6955f09fc3d7bf8995764f073278dd9d507cdd7f1bedcf0d4'
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
