require 'buildsystems/python'

class Py3_alabaster < Python
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  @_ver = '0.7.13'
  version "#{@_ver}-py3.12"
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'https://github.com/bitprophet/alabaster.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.13-py3.12_armv7l/py3_alabaster-0.7.13-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.13-py3.12_armv7l/py3_alabaster-0.7.13-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.13-py3.12_i686/py3_alabaster-0.7.13-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.13-py3.12_x86_64/py3_alabaster-0.7.13-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ab679526f7f0bad267d8f4dd03c3c2cab94bef7111cf8ecdd6b00db91c51e738',
     armv7l: 'ab679526f7f0bad267d8f4dd03c3c2cab94bef7111cf8ecdd6b00db91c51e738',
       i686: '0d22ad3826e6080ff23b2d6d469f9451322a16a0c10df923bbd1818ce737bc11',
     x86_64: '6d9c2f7fe045eb5721d4e5e148dcafc6c0103153350bc150c778e3797cbdf171'
  })

  depends_on 'python3' => :build
end
