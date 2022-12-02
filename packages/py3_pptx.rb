require 'package'

class Py3_pptx < Package
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  @_ver = '0.6.21'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/scanny/python-pptx.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21-py3.11_armv7l/py3_pptx-0.6.21-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21-py3.11_armv7l/py3_pptx-0.6.21-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21-py3.11_i686/py3_pptx-0.6.21-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21-py3.11_x86_64/py3_pptx-0.6.21-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4d5c70c517f821c27ffb8f95314853442c0908efa29975fe72dee51f95f734ac',
     armv7l: '4d5c70c517f821c27ffb8f95314853442c0908efa29975fe72dee51f95f734ac',
       i686: '58ea372b13ebe471be996254aa0bfe77b96f5a65cfcd36b5ae4eb58a7674560b',
     x86_64: '93d7fb523bf559bd59b679fcda034622bc67cf595274195520dfa669672d09fa'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
