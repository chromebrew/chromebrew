require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  @_ver = '2.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_soupsieve/2.5-py3.12_armv7l/py3_soupsieve-2.5-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_soupsieve/2.5-py3.12_armv7l/py3_soupsieve-2.5-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_soupsieve/2.5-py3.12_i686/py3_soupsieve-2.5-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_soupsieve/2.5-py3.12_x86_64/py3_soupsieve-2.5-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2b5585084c12f3daeeae7ca1ed970722c4316045c1d55b2772e37312a1820f36',
     armv7l: '2b5585084c12f3daeeae7ca1ed970722c4316045c1d55b2772e37312a1820f36',
       i686: '571b62a27d6dd9537a8cdf76d54ea84d019fbdff83c759c63d094564d1bd416b',
     x86_64: 'd810509ae28de23e382a51d889afe003bcfd4eb31687b50285bc5f5f7f37f991'
  })

  depends_on 'python3' => :build
end
