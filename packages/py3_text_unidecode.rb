require 'package'

class Py3_text_unidecode < Package
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  @_ver = '1.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kmike/text-unidecode.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-py3.11_armv7l/py3_text_unidecode-1.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-py3.11_armv7l/py3_text_unidecode-1.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-py3.11_i686/py3_text_unidecode-1.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_text_unidecode/1.3-py3.11_x86_64/py3_text_unidecode-1.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '79bbad8f4f56185380fbe81bc892df701d16b9f20feab779daed8366616f3eb3',
     armv7l: '79bbad8f4f56185380fbe81bc892df701d16b9f20feab779daed8366616f3eb3',
       i686: 'c407b2d8a7dafc253613a0d87f4418ba6edf9e6cc8badc1543b6fa4f7c692f15',
     x86_64: '47e70367c0e7296a67faafbd70085f8b08db9ccfd38f7cca3eeca83d776c2623'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
