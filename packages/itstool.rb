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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/itstool/2.0.7_x86_64/itstool-2.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '051b42e8eeb683dd174a593fb0740ce0e375e59decc420f2216ec27d6fc5f653',
     armv7l: '051b42e8eeb683dd174a593fb0740ce0e375e59decc420f2216ec27d6fc5f653',
     x86_64: 'a992780f5ebdeb44b9102df8c55fedb0683d131f5828829afa6f4332f0cbe9f8'
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
