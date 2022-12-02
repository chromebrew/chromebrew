require 'package'

class Py3_tomli_w < Package
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli-w.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-py3.11_armv7l/py3_tomli_w-1.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-py3.11_armv7l/py3_tomli_w-1.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-py3.11_i686/py3_tomli_w-1.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0-py3.11_x86_64/py3_tomli_w-1.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '514139d606b07fdad8f18d6746352829a8f48720af57e1115e58cfc7fe825cd6',
     armv7l: '514139d606b07fdad8f18d6746352829a8f48720af57e1115e58cfc7fe825cd6',
       i686: 'a153a6b599eb2a88bdf607c1a3940dc25b7ee37c44c002ce62ea4cddf0caccbd',
     x86_64: 'aa29c189142e296e198731300529231e5f36730ab028aa887a9d31213245b588'
  })

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
