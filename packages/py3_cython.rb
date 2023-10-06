require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '3.0.3'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.3-py3.12_armv7l/py3_cython-3.0.3-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.3-py3.12_armv7l/py3_cython-3.0.3-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.3-py3.12_i686/py3_cython-3.0.3-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/3.0.3-py3.12_x86_64/py3_cython-3.0.3-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c9e0aba6d5f3012b09e9b4c790b7ac73640d1530c25126015ebf9608722edf90',
     armv7l: 'c9e0aba6d5f3012b09e9b4c790b7ac73640d1530c25126015ebf9608722edf90',
       i686: '0fa98cf7bda95af8d9eb8f311f88a08e741f8aa833daf3ee68e441c642989d65',
     x86_64: 'e36d1de14e0103b109da79eb9771f20da1e5ea10f7e2969aee7a6b4422d28605'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
