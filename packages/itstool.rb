require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  @_ver = '2.0.7'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7_armv7l/itstool-2.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7_armv7l/itstool-2.0.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7_i686/itstool-2.0.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7_x86_64/itstool-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a53d37953b18e110b2b2d18db0db8bb1d82014cc06381c0f8469e85acaed1804',
     armv7l: 'a53d37953b18e110b2b2d18db0db8bb1d82014cc06381c0f8469e85acaed1804',
       i686: '71bbd185b2028e885ea5e3cc3bf7ff997d485747d2d11a8997acfad57f311b3a',
     x86_64: '25530780e3c206688d01f4d9c27fa1ac86049256ead47c441d0e6a1c4878fc50'
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
