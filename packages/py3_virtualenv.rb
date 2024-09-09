require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version '20.26.4-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a21812465e9c19a80275f3232c94c84cd3c5bb7d19023dc9051ced2ed8c76f59',
     armv7l: 'a21812465e9c19a80275f3232c94c84cd3c5bb7d19023dc9051ced2ed8c76f59',
       i686: '729aa2163fe542604613a1ab9260ac2e3231c5d6ef1b75ff60251ec5d97e887c',
     x86_64: 'c346e39985eadc87d2a7d20325c8be12ba33634019491a86af8ce82080a58a2a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
