require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version "#{@_ver}-py3.11"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11_armv7l/py3_packaging-21.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11_armv7l/py3_packaging-21.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11_i686/py3_packaging-21.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11_x86_64/py3_packaging-21.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '054e3e64cc9b74492064908f16be5951311e314858085a638afbbe10f4e3af4b',
     armv7l: '054e3e64cc9b74492064908f16be5951311e314858085a638afbbe10f4e3af4b',
       i686: '6e319e19bcc16d562bc4db5b056136c3a160c9496c75f913f3b89bd25608c5aa',
     x86_64: '86db6c8d0e2f7214bb86d48f8d2566d4085f266697fe801b36448dbd0229e942'
  })

  depends_on 'python3'
  depends_on 'py3_pyparsing'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
