require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.9.12'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12_armv7l/py3_libxml2-2.9.12-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12_armv7l/py3_libxml2-2.9.12-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12_x86_64/py3_libxml2-2.9.12-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6e56764b886b8a311031ec5f8f7d25aa2593e28a34e79f0b15d87ab462a7f403',
     armv7l: '6e56764b886b8a311031ec5f8f7d25aa2593e28a34e79f0b15d87ab462a7f403',
     x86_64: 'd9f41187eae16e4c3dd25a647b12f6a7b9b5a4511a13bddc915a68d36fb19b7a'
  })

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'py3_setuptools' => :build

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
