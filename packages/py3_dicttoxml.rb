require 'package'

class Py3_dicttoxml < Package
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/quandyfactory/dicttoxml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1_armv7l/py3_dicttoxml-1.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1_armv7l/py3_dicttoxml-1.3.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1_x86_64/py3_dicttoxml-1.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2768c5f5a8030c4c767527190858affc5f08615c8fd51306747cc940520c1146',
     armv7l: '2768c5f5a8030c4c767527190858affc5f08615c8fd51306747cc940520c1146',
     x86_64: '2d1ac6c009956ef58fb036072918ca327adfaf8b9c689d1bc0cd058dbed3eecf'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
