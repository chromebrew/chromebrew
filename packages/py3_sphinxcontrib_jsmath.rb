require 'package'

class Py3_sphinxcontrib_jsmath < Package
  description 'sphinxcontrib-jsmath is a sphinx extension which renders display math in HTML via JavaScript.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-jsmath.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-py3.11_armv7l/py3_sphinxcontrib_jsmath-1.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-py3.11_armv7l/py3_sphinxcontrib_jsmath-1.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-py3.11_i686/py3_sphinxcontrib_jsmath-1.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-py3.11_x86_64/py3_sphinxcontrib_jsmath-1.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '11d23fedee7fbfe991c3d9e4c3fafca38a19381ab7e87ba5e794c629c5b1d7f7',
     armv7l: '11d23fedee7fbfe991c3d9e4c3fafca38a19381ab7e87ba5e794c629c5b1d7f7',
       i686: '0d88749a9de36f18e4df5c16a280ac836c7edf29021de543137a91afde7248ae',
     x86_64: 'fa9f5d30f4d0b34e343c5c265032bc4f6e6398a0c78b19420c610f7d3a4a518f'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
