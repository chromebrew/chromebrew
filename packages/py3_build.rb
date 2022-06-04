require 'package'

class Py3_build < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '0.8.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0-1_armv7l/py3_build-0.8.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0-1_armv7l/py3_build-0.8.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0-1_i686/py3_build-0.8.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0-1_x86_64/py3_build-0.8.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fad4cbbb4220a513f0357cd549f5d9760dfbb542cdca26564aff7bee1b3cf280',
     armv7l: 'fad4cbbb4220a513f0357cd549f5d9760dfbb542cdca26564aff7bee1b3cf280',
       i686: 'ded0af9208dc6465bfc84b78e922e2243a4a95e8c4969e4eb57e206203c9eb54',
     x86_64: '820bc24d5da0c2394fa587b3b41f62b5bf4903a7eb91263ef555380f367bc9a3'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pep517'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
