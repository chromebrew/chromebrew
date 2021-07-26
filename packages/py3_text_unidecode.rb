require 'package'

class Py3_text_unidecode < Package
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  @_ver = '1.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kmike/text-unidecode.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3_armv7l/py3_text_unidecode-1.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3_armv7l/py3_text_unidecode-1.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3_i686/py3_text_unidecode-1.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3_x86_64/py3_text_unidecode-1.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '27bfe9b9931884739864f2ce718526060b86171a780f0115294a1933f3e0c714',
     armv7l: '27bfe9b9931884739864f2ce718526060b86171a780f0115294a1933f3e0c714',
       i686: 'c07ceff06fb6fc8101395a8d59f8a9c980a0fb0b5eb8a13df64557def90c7c6c',
     x86_64: 'feeba57cf3f5c2f0e6971b94594c4868043d93c1597da0ec16bf3c15c6d95ce2'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
