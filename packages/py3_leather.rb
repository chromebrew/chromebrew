require 'package'

class Py3_leather < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  @_ver = '0.3.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4-py3.11_armv7l/py3_leather-0.3.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4-py3.11_armv7l/py3_leather-0.3.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4-py3.11_i686/py3_leather-0.3.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4-py3.11_x86_64/py3_leather-0.3.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '62d3e162fdfdf0271105bff92d10c52ec3e16a1e77fd28de06816e21369858db',
     armv7l: '62d3e162fdfdf0271105bff92d10c52ec3e16a1e77fd28de06816e21369858db',
       i686: '807bba928e7f04eeee2f4a0c97f6c6b889e31ced0050d9187581d34f7699cb16',
     x86_64: '7bb7a780eb641936d1dfc1c843d276e42ca5bafb3d11cedabfbf45319783fb7f'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
