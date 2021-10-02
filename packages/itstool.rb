require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  @_ver = '2.0.6'
  version "#{@_ver}-2"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.6-2_armv7l/itstool-2.0.6-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.6-2_armv7l/itstool-2.0.6-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.6-2_i686/itstool-2.0.6-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.6-2_x86_64/itstool-2.0.6-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '93c92457c4087d06554d9217b5f56d275a1dd401129e8f8598ec79c22debae99',
     armv7l: '93c92457c4087d06554d9217b5f56d275a1dd401129e8f8598ec79c22debae99',
       i686: '96d8d7deb9e0ddcb9283092c4551d6c801af51c511a50f511b3d61bf997e22b1',
     x86_64: '61ad649af3ed493056b27350cf3491e7a6ada6d472dbb5d82f6586e7d5a2de6c'
  })

  depends_on 'py3_libxml2'
  depends_on 'py3_setuptools' => :build

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
