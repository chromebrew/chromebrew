require 'package'

class Py3_tomli_w < Package
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  @_ver = '1.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli-w.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0_armv7l/py3_tomli_w-1.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0_armv7l/py3_tomli_w-1.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0_i686/py3_tomli_w-1.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli_w/1.0.0_x86_64/py3_tomli_w-1.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '446079f23706d1e23af65ff654b8e373aec8c3202c99978faea6accc9d7c706b',
     armv7l: '446079f23706d1e23af65ff654b8e373aec8c3202c99978faea6accc9d7c706b',
       i686: '1f7ab0a43dd6168dee084f3f293cbcf405c060331bb819cdfac867dd654001c2',
     x86_64: '6a386b76da03628b1a46f24996370e0a8a9eb6c9c35d0952c9bd63c122e316dc'
  })

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
