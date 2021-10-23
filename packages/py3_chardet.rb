require 'package'

class Py3_chardet < Package
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  @_ver = '4.0.0'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/chardet/chardet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-1_armv7l/py3_chardet-4.0.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-1_armv7l/py3_chardet-4.0.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-1_i686/py3_chardet-4.0.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-1_x86_64/py3_chardet-4.0.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '210fe2f123e06f2d9a2308dfaddcf4069c345db1627feeb654a90bb09830ed0a',
     armv7l: '210fe2f123e06f2d9a2308dfaddcf4069c345db1627feeb654a90bb09830ed0a',
       i686: 'eb3fa8e415817015c393a428d416a645cab1044b546839651e74d05f4a0218f8',
     x86_64: '62107dbb08abf09ab0f8290399f2f3c1a0cdbaa61b845138fc8b791e127be567'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
