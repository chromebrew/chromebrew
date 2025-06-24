require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.10-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfd4333fa70ddc19f610dc220406a23a3cdf2e90f643d48a6fddf1e3374e22e5',
     armv7l: 'dfd4333fa70ddc19f610dc220406a23a3cdf2e90f643d48a6fddf1e3374e22e5',
       i686: '7506957e3028b1da8da0c498c60bcf2636cf3f9a2b17bb6335bcaab93e51f999',
     x86_64: 'be0824b4a6696614cd093277c631b448ddffe770cb104ba6e13eeda5ea57a455'
  })

  depends_on 'python3' => :build

  no_source_build
end
