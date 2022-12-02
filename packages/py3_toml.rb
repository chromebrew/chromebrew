require 'package'

class Py3_toml < Package
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  @_ver = '0.10.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uiri/toml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-py3.11_armv7l/py3_toml-0.10.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-py3.11_armv7l/py3_toml-0.10.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-py3.11_i686/py3_toml-0.10.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2-py3.11_x86_64/py3_toml-0.10.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '05f48757e7d9841ce3f5c2063af515dd940860a8d9b210b0ebe9432f270bb131',
     armv7l: '05f48757e7d9841ce3f5c2063af515dd940860a8d9b210b0ebe9432f270bb131',
       i686: '0016acd5e7ad0301bf158bae609e4a34cbb63ea347a0c07ab301e2fe65768c45',
     x86_64: 'ccf6bd61f11662b7ae1b2017bc94c675bcd6ca9c3a0fd4d1c80ead0995e81d5a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
