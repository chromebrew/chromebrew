require 'package'

class Py3_sphinxcontrib_serializinghtml < Package
  description 'sphinxcontrib-serializinghtml is a sphinx extension which outputs "serialized" HTML files (json and pickle).'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.1.5'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-serializinghtml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5-py3.11_armv7l/py3_sphinxcontrib_serializinghtml-1.1.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5-py3.11_armv7l/py3_sphinxcontrib_serializinghtml-1.1.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5-py3.11_i686/py3_sphinxcontrib_serializinghtml-1.1.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5-py3.11_x86_64/py3_sphinxcontrib_serializinghtml-1.1.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ba397c8dcf1d3080c189329654faa41e652ba5765e7a388901797ff3219e6553',
     armv7l: 'ba397c8dcf1d3080c189329654faa41e652ba5765e7a388901797ff3219e6553',
       i686: '5bea2a3e4193d9e6a1d4db3c1d382a11f78759d0523d5baae52d586891bbf8cc',
     x86_64: 'c40c5424f59918ad5d21be8330ca9c1fa100e3b02593fe75e56afaafbd252224'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
