require 'package'

class Py3_cssselect < Package
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  @_ver = '1.1.0'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/scrapy/cssselect.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-py3.11_armv7l/py3_cssselect-1.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-py3.11_armv7l/py3_cssselect-1.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-py3.11_i686/py3_cssselect-1.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-py3.11_x86_64/py3_cssselect-1.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd4ad31bc93c4e45c15c5e8f2db59e3680af163cc33e8a548b5c4d40bd8866fa9',
     armv7l: 'd4ad31bc93c4e45c15c5e8f2db59e3680af163cc33e8a548b5c4d40bd8866fa9',
       i686: '5cc74206bdf8fc42cf193fcfd5ded61a42eda6bdb80fdd2b6fc58b719c119dc7',
     x86_64: '50db0afcfb22bfac8a45fc3d7691b424e17b78055c978c80365a9f0657908729'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
