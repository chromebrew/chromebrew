require 'package'

class Py3_slugify < Package
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  @_ver = '5.0.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/un33k/python-slugify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.1_armv7l/py3_slugify-5.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.1_armv7l/py3_slugify-5.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.1_x86_64/py3_slugify-5.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4c62ddf03f67ef4169a7f5f8bc1594e70f0d5af1161ad25d8d263fe080ab611c',
     armv7l: '4c62ddf03f67ef4169a7f5f8bc1594e70f0d5af1161ad25d8d263fe080ab611c',
     x86_64: '9f2fe8908a21c4d84914c8ee85facf56e752b8d768449b429297ac616a0c291b'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
