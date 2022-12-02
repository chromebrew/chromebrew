require 'package'

class Py3_importlib_metadata < Package
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  @_ver = '4.8.1'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/python/importlib_metadata.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1-py3.11_armv7l/py3_importlib_metadata-4.8.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1-py3.11_armv7l/py3_importlib_metadata-4.8.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1-py3.11_i686/py3_importlib_metadata-4.8.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1-py3.11_x86_64/py3_importlib_metadata-4.8.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ecc505c35fc39013c935a204d2cb80331ff6f43b30f3c9cfec954201af6e663',
     armv7l: '2ecc505c35fc39013c935a204d2cb80331ff6f43b30f3c9cfec954201af6e663',
       i686: '5c42ad69555c902f5d9877ac6d84ad235a68737d18340e36296209846f50dc93',
     x86_64: 'fb3f00751349b6728c3dde134079a9249db92914a8d9d0d3a49b23c4fa1aee11'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
