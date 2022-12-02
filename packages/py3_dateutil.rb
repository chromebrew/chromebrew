require 'package'

class Py3_dateutil < Package
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  @_ver = '2.8.2'
  version "#{@_ver}-py3.11"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.11_armv7l/py3_dateutil-2.8.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.11_armv7l/py3_dateutil-2.8.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.11_i686/py3_dateutil-2.8.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.11_x86_64/py3_dateutil-2.8.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd2c2dcc4a88b77ed1952c4804b06515251b261730ef75cbb4251f94f5861ebb3',
     armv7l: 'd2c2dcc4a88b77ed1952c4804b06515251b261730ef75cbb4251f94f5861ebb3',
       i686: '8fbb13c0bc0a0b23d7519804db1cbb1e3ffaf4ae96d8c5c74800b494a1ca802b',
     x86_64: '2040989794fa0663e1761f168a8b33c8fb32307ed4e9e90e2d8142beddb9ba44'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
