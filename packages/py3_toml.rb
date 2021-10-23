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
    aarch64: '66678cd01f5e6f043e02994646ff20c99a0e0b61dcfbbfaf1bfb6c171c7acf6e',
     armv7l: '66678cd01f5e6f043e02994646ff20c99a0e0b61dcfbbfaf1bfb6c171c7acf6e',
       i686: 'db9416f69290b1ed697cbe89ac50270cbeab62048bd4ee8dea7e08c59f8d5301',
     x86_64: 'cf5222ed4bdeacb91ea7fd6044c546e226272c92988a97cb539e6b98491d68e8'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
