require 'package'

class Py3_magic < Package
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.24'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_armv7l/py3_magic-0.4.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_armv7l/py3_magic-0.4.24-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_i686/py3_magic-0.4.24-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_x86_64/py3_magic-0.4.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ce381fbc4eaacd4b1d745e843b052ce9a3ca9f31eb17f3f30749cde37a16c0c3',
     armv7l: 'ce381fbc4eaacd4b1d745e843b052ce9a3ca9f31eb17f3f30749cde37a16c0c3',
       i686: '8e4a0371666c8d5926caea0b13c70e5f3fd0eda4db2fefe201d14a35b3496ab2',
     x86_64: '3bde9fcf96fbaaefa16bf9d8e0c339342c790d4a9b8f17adabc6778d9966a0d7'
  })

  depends_on 'filecmd'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
