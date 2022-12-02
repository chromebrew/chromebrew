require 'package'

class Py3_tomli < Package
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_armv7l/py3_tomli-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_armv7l/py3_tomli-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_i686/py3_tomli-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_x86_64/py3_tomli-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c1cbd5cca3f25ac60ecedd3ff81a375e3204ecf1e826e77c818d49282a62773a',
     armv7l: 'c1cbd5cca3f25ac60ecedd3ff81a375e3204ecf1e826e77c818d49282a62773a',
       i686: '855f097145db0fed4c2ed028fbb54cc2c9c19fa3c2d7e1da3b187f59b8707d81',
     x86_64: '481708d09dd1b328967ffbb769c7f97e12169a2901f04483ad577f3a03756d9d'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
