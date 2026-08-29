require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '261b2501fc4cea52e034f6c48f50cac3666043f12793ff93d8d783605959a79e',
     armv7l: '261b2501fc4cea52e034f6c48f50cac3666043f12793ff93d8d783605959a79e',
       i686: '79e919c1d7724d963b18c678ea1262158d05ad84f0185b330bcb81dc140ad4be',
     x86_64: '79e919c1d7724d963b18c678ea1262158d05ad84f0185b330bcb81dc140ad4be'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
