require 'buildsystems/python'

class Py3_cython < Python
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '3.0.2'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.2-py3.12_armv7l/py3_cython-3.0.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.2-py3.12_armv7l/py3_cython-3.0.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.2-py3.12_i686/py3_cython-3.0.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.2-py3.12_x86_64/py3_cython-3.0.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2f7534ef55878e309ba6d69a46438737dee38a0b03e6bdb0bd0e36b1982b8ca7',
     armv7l: '2f7534ef55878e309ba6d69a46438737dee38a0b03e6bdb0bd0e36b1982b8ca7',
       i686: 'd0a5357408f4a24ed5683c62345fbbb963a8242d00b0b844e9a518240f930dff',
     x86_64: '0f917deb53499e738aab66b0de846c4aa91c3732ef03eeed89b4e08b409becbb'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
