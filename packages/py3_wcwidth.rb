require 'package'

class Py3_wcwidth < Package
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.5'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_armv7l/py3_wcwidth-0.2.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_armv7l/py3_wcwidth-0.2.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_i686/py3_wcwidth-0.2.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_x86_64/py3_wcwidth-0.2.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f3a1cc943cf945d22981a0a9a48c1c8f44e03b96cd9ed5c41805ed0a65ee1acf',
     armv7l: 'f3a1cc943cf945d22981a0a9a48c1c8f44e03b96cd9ed5c41805ed0a65ee1acf',
       i686: '66f9c6a712e15f61ad91d6f594bfdd3a2089578efa4e28f246f5af258a6a8885',
     x86_64: 'a760f2d5300a1d55fcf61728cfe32f826e5dbc949e87d77650ece4b09fa0e17d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
