require 'package'

class Py3_tomli < Package
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli.git'
  git_hashtag @_ver

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.12_x86_64/py3_tomli-2.0.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '4a0c7533e2b146e37ccf84c7e66b54f999dfe5ffc49af16529520aaa4fed693c'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
