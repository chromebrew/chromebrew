require 'package'

class Py3_babel < Package
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  @_ver = '2.9.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-babel/babel.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-py3.11_armv7l/py3_babel-2.9.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-py3.11_armv7l/py3_babel-2.9.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-py3.11_i686/py3_babel-2.9.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-py3.11_x86_64/py3_babel-2.9.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b1de47684189e60d59420ed6c59775dce31e5faeb45ac8b5c797ed1b45ccca03',
     armv7l: 'b1de47684189e60d59420ed6c59775dce31e5faeb45ac8b5c797ed1b45ccca03',
       i686: '29d087637b4ec81d39789fce59059883f71005b5b568ecd3f4ed5f7e3f82d045',
     x86_64: '5657cd34f9ee36d81f0c33a22e0202d22cda2b0275289cff8d6a900f90701c10'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
