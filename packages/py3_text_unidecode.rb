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
    aarch64: '6e0412e52f5f3ff9f5b4fedb5b04284046db0f2167eab863e5ca5cf314fef7a0',
     armv7l: '6e0412e52f5f3ff9f5b4fedb5b04284046db0f2167eab863e5ca5cf314fef7a0',
       i686: '7201bcef7316e2aa9ebb4058a239de9cda3cbf9da5e5eb555f8f745f95af7153',
     x86_64: 'fbb154a8fea012d4cb6478ca0ac3f606ab645ff0cd78ddc6ac1e5e6895ff4718'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
