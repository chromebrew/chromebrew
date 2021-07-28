require 'package'

class Py3_pluggy < Package
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  @_ver = '0.13.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pluggy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/0.13.1_armv7l/py3_pluggy-0.13.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/0.13.1_armv7l/py3_pluggy-0.13.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/0.13.1_i686/py3_pluggy-0.13.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/0.13.1_x86_64/py3_pluggy-0.13.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b52471f3165e506014641212c666b4b0cd83554a420f9b956c528a5941efc0b0',
     armv7l: 'b52471f3165e506014641212c666b4b0cd83554a420f9b956c528a5941efc0b0',
       i686: 'b95f3e24bcd6e1feeb40e4f3f1a85b49942117d0b2ad84a783a0c947f6593ea6',
     x86_64: '65b5e572673f2c23516b5eb728dba13a9ab228e992170e0237cb84e54319e38a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
