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
    aarch64: '5b6ff8cdb0e22b2d708c3997357380f6c6b3fd32d2d24d40e1527de92f41e9ed',
     armv7l: '5b6ff8cdb0e22b2d708c3997357380f6c6b3fd32d2d24d40e1527de92f41e9ed',
       i686: 'a9cad3705d565664807e9df2a8232d09787acfa9dc7b1d4695052c39751d6df1',
     x86_64: '29890eca05c4c20a9b314746c22d13501a77b7ec1f24c86fdebf6681533b623a'
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
