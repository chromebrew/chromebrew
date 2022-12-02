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
    aarch64: 'f62325e7769ae74eb20c83e5b03b53659911c231a295d9b32cf905490942bc3c',
     armv7l: 'f62325e7769ae74eb20c83e5b03b53659911c231a295d9b32cf905490942bc3c',
       i686: '6bfa2e877c594e9b45b1ef7fde31e61ce88642574c17fadd19aaf227c8a01073',
     x86_64: '636fd08cfbfe22116e5712aa89106f9fe3929ca65845f03240f5ef3d3e615494'
  })

  depends_on 'python3'
  depends_on 'py3_pyparsing'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
