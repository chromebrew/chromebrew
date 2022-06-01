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
    aarch64: '1aee846a7f90e915453fae80cb3ae8aa4dfe39e2c66e042d3ff6d1517c481a09',
     armv7l: '1aee846a7f90e915453fae80cb3ae8aa4dfe39e2c66e042d3ff6d1517c481a09',
       i686: '5ba5e254c593888abbf928f5f9083c33d50d0a29f53f0f56974aee6b6479359b',
     x86_64: '4636e928541d5297f25be36e79ad56eb06733d4c338c9a149628f39bf01fae46'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
