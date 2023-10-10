require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.12"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.12_armv7l/itstool-2.0.7-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.12_armv7l/itstool-2.0.7-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.12_i686/itstool-2.0.7-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7-py3.12_x86_64/itstool-2.0.7-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '06017558272345296c481a9ec3efd97a4011a8440aaa5768635920bda546cc1d',
     armv7l: '06017558272345296c481a9ec3efd97a4011a8440aaa5768635920bda546cc1d',
       i686: '72f2044e98d74fc43e83f5905314f5a7149da152868d917c8eada261142610b1',
     x86_64: '57c747287878cb1357f04f076e2884b332251f882ddd9250d8688a76d624c090'
  })

  depends_on 'py3_libxml2' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
