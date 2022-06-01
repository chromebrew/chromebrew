require 'package'

class Py3_slugify < Package
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  @_ver = '5.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/un33k/python-slugify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2_armv7l/py3_slugify-5.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2_armv7l/py3_slugify-5.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2_i686/py3_slugify-5.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2_x86_64/py3_slugify-5.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '93db1b5b49bf48d40ce694df1d007bc4d6711887001c376c5e5cb7eb057f549b',
     armv7l: '93db1b5b49bf48d40ce694df1d007bc4d6711887001c376c5e5cb7eb057f549b',
       i686: '31fb8f5268cff92b3e43a138c093b09c76beffc33997ba233796a0bc006a4d2a',
     x86_64: '368a3f138195f3d312e71102b6a00a524e60dd4102e09b3f40046eb4e441d2a6'
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
