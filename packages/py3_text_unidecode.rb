require 'package'

class Py3_text_unidecode < Package
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  @_ver = '1.3'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kmike/text-unidecode.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
