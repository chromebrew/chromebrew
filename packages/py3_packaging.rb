require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version "#{@_ver}-py3.11-1"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11-1_armv7l/py3_packaging-21.3-py3.11-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11-1_armv7l/py3_packaging-21.3-py3.11-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11-1_i686/py3_packaging-21.3-py3.11-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.11-1_x86_64/py3_packaging-21.3-py3.11-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '097ccfde58edcc1ac561395e4166ef740d7a60bee9ecd71812b85ad09e039b67',
     armv7l: '097ccfde58edcc1ac561395e4166ef740d7a60bee9ecd71812b85ad09e039b67',
       i686: 'fbddfd586a8d51ae760e19529bf0d2d961406588ae8aa7987fb2a9f5eb9d8afd',
     x86_64: '55e83f3a7309f2cda7839c19b6f8db338e4b1d9df9ea594fb8a42731eb2c9b65'
  })

  depends_on 'python3'
  depends_on 'py3_pep517' => :build
  depends_on 'py3_pyparsing'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
