require 'package'

class Py3_sphinxcontrib_htmlhelp < Package
  description 'sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '2.0.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-htmlhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_i686/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_x86_64/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a53e9b7b4a8295b0ba6eb8f77bc55375b823ba72b8007ab2a4cf877d94ec1707',
     armv7l: 'a53e9b7b4a8295b0ba6eb8f77bc55375b823ba72b8007ab2a4cf877d94ec1707',
       i686: 'cbb060fb041f5e54d7069f7ada7c0884486f0fba4d7c35445a9d60ca434cecc0',
     x86_64: 'acfb71ffedd0625e70b6cb47fa6f60f4d0bceab478caa62184f51a41d29c73eb'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
