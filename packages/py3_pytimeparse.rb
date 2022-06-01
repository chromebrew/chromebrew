require 'package'

class Py3_pytimeparse < Package
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  @_ver = '1.1.8'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_armv7l/py3_pytimeparse-1.1.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_armv7l/py3_pytimeparse-1.1.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_i686/py3_pytimeparse-1.1.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_x86_64/py3_pytimeparse-1.1.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '47cbd8c39c0f08f252ae9c83d09f48476e1ec5481fe16c1ee5a5470e0f462446',
     armv7l: '47cbd8c39c0f08f252ae9c83d09f48476e1ec5481fe16c1ee5a5470e0f462446',
       i686: '908e3b05225e761d451cba630e25416b95b5a73cd145ee39c0d38fd343780961',
     x86_64: '90214d3ab619ac80df3b5fa36a46b5e52a4afedfe834ef8dc847cc612607e16d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
