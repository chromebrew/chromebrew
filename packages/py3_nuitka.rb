require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73f95f81d1c07211efd9003ae2639d7c9f7b05c6ef00a2d73b0fdef5fb13786d',
     armv7l: '73f95f81d1c07211efd9003ae2639d7c9f7b05c6ef00a2d73b0fdef5fb13786d',
       i686: '41f1e67449aec45820d8e3975ef6cd5ca39a1be0cf2f55ac0aad8b671f54dfc3',
     x86_64: '7857e2808b67f69ea284e92708402d3362e5212f6562b38474f25c2155e023bb'
  })

  depends_on 'python3' => :build

  no_source_build
end
