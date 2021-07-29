require 'package'

class Py3_typogrify < Package
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '2.0.7'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mintchaos/typogrify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_armv7l/py3_typogrify-2.0.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_i686/py3_typogrify-2.0.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_typogrify/2.0.7_x86_64/py3_typogrify-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '50f562c28e356a34e6f4bd8146353b6aff50035abe0a123962b08fb7e39090db',
     armv7l: '50f562c28e356a34e6f4bd8146353b6aff50035abe0a123962b08fb7e39090db',
       i686: 'af3b2e1f11a14751d660534c590f7b907992222391a06cd6a1b39eab5ae7d59a',
     x86_64: 'c0681f49f3318b7fb6d40e6a54ef970cac3389accaf2bcd9cd0ccef1de70d81a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
