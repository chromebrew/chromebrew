require 'package'

class Py3_build < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '0.9.0'
  version "#{@_ver}-1-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-1-py3.11_armv7l/py3_build-0.9.0-1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-1-py3.11_armv7l/py3_build-0.9.0-1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-1-py3.11_i686/py3_build-0.9.0-1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-1-py3.11_x86_64/py3_build-0.9.0-1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a9c9fcf17177e0cacf41eb187891ca499122eacd8324ddeb65ce9f71647116bf',
     armv7l: 'a9c9fcf17177e0cacf41eb187891ca499122eacd8324ddeb65ce9f71647116bf',
       i686: 'fdc59807e7f84c345889f3afb67a1f452950d8bd873323b3b9f3f1ec329931d6',
     x86_64: '021cc30ea7a0f270d330f8c08d1f70024be19349d874aff6541c88c332edd847'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pep517' => :build
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
