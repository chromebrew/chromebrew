require 'package'

class Py3_pyte < Package
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.0'
  version "#{@_ver}-py3.11"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-py3.11_armv7l/py3_pyte-0.8.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-py3.11_armv7l/py3_pyte-0.8.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-py3.11_i686/py3_pyte-0.8.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.0-py3.11_x86_64/py3_pyte-0.8.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7d99dc88b1b4c8f473f29f007982e818355737524b61228c536142628d1c21b1',
     armv7l: '7d99dc88b1b4c8f473f29f007982e818355737524b61228c536142628d1c21b1',
       i686: '61678eb755d4d054f9a8d1fa162bcfc5ea5aff3443c63c02a080b159c81587d7',
     x86_64: 'af7c6d22af133bfcc70963ea5c45cbb7e12f654b3c00db80c49fc784a4b4af1c'
  })

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
