require 'package'

class Py3_toml < Package
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  @_ver = '0.10.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uiri/toml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-1_armv7l/py3_toml-0.10.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-1_armv7l/py3_toml-0.10.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-1_i686/py3_toml-0.10.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-1_x86_64/py3_toml-0.10.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '89ed389fc72bbbab53033f089b85d791b6c772970c96c5a8453192dfb938a8c2',
     armv7l: '89ed389fc72bbbab53033f089b85d791b6c772970c96c5a8453192dfb938a8c2',
       i686: '08ae9ab31b374548a5d4c3119f8e386391f59829d4143d016083bf8b59a83195',
     x86_64: 'bb5eefbfd353bcd00335e16d04caff9ea99fc647d60a9c111cd233805f2d3855'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
