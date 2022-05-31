require 'package'

class Py3_tomli < Package
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-1_i686/py3_tomli-2.0.1-1-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-1_x86_64/py3_tomli-2.0.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '15e531254af315f86062535ae7d2433af741fad5d68dd311d5b1a40e6cf0b228',
  x86_64: '32cee6d866aae1faa4442c9a424f1a54cfac8d123350c66b0ef1eb10fb727f8a'
  })

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
