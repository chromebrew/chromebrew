require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version "#{@_ver}-2"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-2_armv7l/py3_packaging-21.3-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-2_armv7l/py3_packaging-21.3-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-2_i686/py3_packaging-21.3-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-2_x86_64/py3_packaging-21.3-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dddc4ef138725db002e41214df0b79e22719b930d0eb8b91b7e2059f1c3b64e9',
     armv7l: 'dddc4ef138725db002e41214df0b79e22719b930d0eb8b91b7e2059f1c3b64e9',
       i686: 'c30dc89d108fabb94855bc0bab22ffb4b9e39d6113f67b64de76cb717c55477a',
     x86_64: '2df6b24cb4a867e840a1380bf0ce7d12b60f2a91de2a2c2df4ead79317233f12'
  })

  depends_on 'py3_pyparsing'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
