require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ac80954eb99e980aa789eda5e834bd05e264e743ad1a1c0dc414e7558b2d7a6',
     armv7l: '9ac80954eb99e980aa789eda5e834bd05e264e743ad1a1c0dc414e7558b2d7a6',
       i686: '47e13b04c943a5bcf348f09bf349041413ffcae09b72a869bc9a14263267cc24',
     x86_64: '63cba54ccc53e44232f1e0dff3fc7a60b41f2e0ae221ecdae7b28cc0c25ed68f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
