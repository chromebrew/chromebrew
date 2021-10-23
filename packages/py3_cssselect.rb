require 'package'

class Py3_cssselect < Package
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  @_ver = '1.1.0'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/scrapy/cssselect.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_armv7l/py3_cssselect-1.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_armv7l/py3_cssselect-1.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_i686/py3_cssselect-1.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_x86_64/py3_cssselect-1.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b2c988ab7370b671da1fccbaa28c248a99dec5c11bcc089f26d0259e3afd34e2',
     armv7l: 'b2c988ab7370b671da1fccbaa28c248a99dec5c11bcc089f26d0259e3afd34e2',
       i686: '528864e73db113217b560d38f50f921bf75a0f00ae54fe6a2ef6fcda7ea14dcf',
     x86_64: '3839629722f436dd58f2043bbf51f6a6103cd98472d7b6bc9a564abcf6a15244'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
