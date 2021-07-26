require 'package'

class Py3_wcwidth < Package
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5_armv7l/py3_wcwidth-0.2.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5_armv7l/py3_wcwidth-0.2.5-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5_x86_64/py3_wcwidth-0.2.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7063a37eb48101ce14322f53766269acf684e8696101d4d8391350cb2dda44cc',
     armv7l: '7063a37eb48101ce14322f53766269acf684e8696101d4d8391350cb2dda44cc',
     x86_64: 'ecbd3bc2b90bd30aeb168c11cd5b98cecf7a1be65d5de4c845810154ee630511'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
