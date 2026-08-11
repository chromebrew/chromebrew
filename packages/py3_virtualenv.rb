require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '370003325f5f795371f8f286834aebd983811d96223e7789e8238ec9264bed24',
     armv7l: '370003325f5f795371f8f286834aebd983811d96223e7789e8238ec9264bed24',
       i686: '3d7b8df084f773f28dd2ac72b9c6fe6300537b0964519f84fa7cf816205ccc67',
     x86_64: '446205bb3cf14a7a68cf72a753f34d74ea5927059178a0276b2aa42e0dc0c3aa'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
