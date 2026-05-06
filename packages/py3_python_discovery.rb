require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5b4547764fa2f2355f03f6a6d59c266f4b28d3da5d878e47cbe17c40152c335',
     armv7l: 'e5b4547764fa2f2355f03f6a6d59c266f4b28d3da5d878e47cbe17c40152c335',
       i686: '2f830d83c6ed10c34eb71e8215fd8d344cd87af718e2148965f65693194bc14b',
     x86_64: '79f5ff8fc019d0ba33f3c014647e5476dc5716884ac04f508328b1cc4db86d6a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
