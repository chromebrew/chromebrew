require 'package'

class Py3_sphinxcontrib_applehelp < Package
  description 'sphinxcontrib-applehelp is a sphinx extension which outputs Apple help books.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-applehelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-1_armv7l/py3_sphinxcontrib_applehelp-1.0.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-1_armv7l/py3_sphinxcontrib_applehelp-1.0.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-1_i686/py3_sphinxcontrib_applehelp-1.0.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-1_x86_64/py3_sphinxcontrib_applehelp-1.0.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5eb244880f6e9639cff6ac632622d3a73c473beb94f682efee8d8937f3b4f403',
     armv7l: '5eb244880f6e9639cff6ac632622d3a73c473beb94f682efee8d8937f3b4f403',
       i686: '407fb0c951ce93a7c58ccd5cccc5174899fc6ea4f8b2a6f0dc908103d0b4775f',
     x86_64: 'fe3dbe1ab139bb18a7f0d7887130b4c0f5087ba941a847ced0d94a7060c72182'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
