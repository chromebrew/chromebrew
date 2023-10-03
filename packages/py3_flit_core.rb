require 'buildsystems/python'

class Py3_flit_core < Python
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.9.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_armv7l/py3_flit_core-3.8.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_armv7l/py3_flit_core-3.8.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_i686/py3_flit_core-3.8.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit_core/3.8.0-py3.11_x86_64/py3_flit_core-3.8.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a7390e8ec96cdf5242195d355fedc6945526102bd2eedde2a953880930baf732',
     armv7l: 'a7390e8ec96cdf5242195d355fedc6945526102bd2eedde2a953880930baf732',
       i686: '600767ee9199ba94647f6f4563576b3aaec4f2507ccde986b81e44292282ef34',
     x86_64: '196205fe3d3b2950510d4bcfd0d6c0d6812906cc4fe7270eaeb73d78cac8bb5a'
  })

  depends_on 'python3'
end
