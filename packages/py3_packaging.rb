require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version "#{@_ver}-1"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-1_armv7l/py3_packaging-21.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-1_armv7l/py3_packaging-21.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-1_i686/py3_packaging-21.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-1_x86_64/py3_packaging-21.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bda279e8aee2afcabbf2fe1991a91480254f8d1bc660f4756a05a6c2fd976c2c',
     armv7l: 'bda279e8aee2afcabbf2fe1991a91480254f8d1bc660f4756a05a6c2fd976c2c',
       i686: '01428054eeae4807ad922c8c3c61ccae181418ff740553ffd40e88235b5400a7',
     x86_64: 'a73d7698a0828726649302974e125cb512de29ffd4364aa9a983f365b6cb2ec9'
  })

  depends_on 'py3_pyparsing'

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
