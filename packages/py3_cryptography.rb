require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '38.0.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/38.0.4-py3.11_armv7l/py3_cryptography-38.0.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/38.0.4-py3.11_armv7l/py3_cryptography-38.0.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/38.0.4-py3.11_i686/py3_cryptography-38.0.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/38.0.4-py3.11_x86_64/py3_cryptography-38.0.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b8c0219063f84c3a9b666afbe2625380cdb7505d903140cd978c8eab2f695215',
     armv7l: 'b8c0219063f84c3a9b666afbe2625380cdb7505d903140cd978c8eab2f695215',
       i686: '8869ebcc0faa36c11a855f4ecca89e82fbfeae3d41cde77990032acb7826bfc4',
     x86_64: 'c4a588c27d2f363483a5f2d3746158c8919f8e29dab2232a1f3342f05567a980'
  })

  depends_on 'py3_cffi'
  depends_on 'py3_typing_extensions'
  depends_on 'python3_rust' => :build
  depends_on 'py3_pycparser' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
