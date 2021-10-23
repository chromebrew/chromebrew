require 'package'

class Py3_dicttoxml < Package
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/quandyfactory/dicttoxml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_armv7l/py3_dicttoxml-1.3.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_armv7l/py3_dicttoxml-1.3.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_i686/py3_dicttoxml-1.3.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_x86_64/py3_dicttoxml-1.3.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '63d41b40cfc5e2fd0c94855f3b28eaa00bb0c07718216b0e546ecd355a5b20c1',
     armv7l: '63d41b40cfc5e2fd0c94855f3b28eaa00bb0c07718216b0e546ecd355a5b20c1',
       i686: 'e71d4b19bbb28f396b714c4c7e31e961865bdc665e1e6bfb161ad669244f4309',
     x86_64: 'e7edfc9b347f2915818f506902f055e15cb7caed7ecb071b864a0ad2fa4c50cc'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
