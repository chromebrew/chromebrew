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

  depends_on 'py3_text_unidecode'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
