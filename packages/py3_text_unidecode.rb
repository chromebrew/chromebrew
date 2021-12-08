require 'package'

class Py3_text_unidecode < Package
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  @_ver = '1.3'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kmike/text-unidecode.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-1_armv7l/py3_text_unidecode-1.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-1_armv7l/py3_text_unidecode-1.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-1_i686/py3_text_unidecode-1.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-1_x86_64/py3_text_unidecode-1.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7a6071fa9a7f3178c677f092b13b8ca2ddcb7ab7cbc1cea7e2824c79cb4d15ec',
     armv7l: '7a6071fa9a7f3178c677f092b13b8ca2ddcb7ab7cbc1cea7e2824c79cb4d15ec',
       i686: '6ffeca7fd41258252a751a0554e9a2017fc8b581b2a8d865e9ba83690c4e4969',
     x86_64: '3d4429a6036811d561b1f6619f94dfeefadad4de79ed0d41964ba146e6cfc605'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
