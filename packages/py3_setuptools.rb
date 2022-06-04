require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '62.3.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/62.3.2-1_armv7l/py3_setuptools-62.3.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/62.3.2-1_armv7l/py3_setuptools-62.3.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/62.3.2-1_i686/py3_setuptools-62.3.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/62.3.2-1_x86_64/py3_setuptools-62.3.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ed19d9aaf456c27cfdf4710da4fab2ad2e812534d6cd231bd33cbd9a5af8cd4a',
     armv7l: 'ed19d9aaf456c27cfdf4710da4fab2ad2e812534d6cd231bd33cbd9a5af8cd4a',
       i686: 'dd44b626a2a870243a86437c5e78291253fa9f8b535c96dfd776ca8770f64290',
     x86_64: '714df6d99e3c8b369930197ee71dd0d6f21862ffdbf9c136f960eab1323f27bb'
  })

  depends_on 'py3_packaging'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
