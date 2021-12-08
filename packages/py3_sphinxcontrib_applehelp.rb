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
    aarch64: '919c67fb73d440175273648368279e12c43ae88999461ce643fb18a5e5221020',
     armv7l: '919c67fb73d440175273648368279e12c43ae88999461ce643fb18a5e5221020',
       i686: 'ef6ad478419ab58f27480ca2ebe5aa051306b037273bc1c6863fba269d45e337',
     x86_64: 'a2992c9ad8cdd021aa9a41187c50d274ba1f6add006955bebcce6fac78b6cbc9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
