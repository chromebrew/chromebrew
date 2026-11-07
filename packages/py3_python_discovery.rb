require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0298ecc5c524bb7cc05b2a2905692059c9b9429a108a9dab4f575193108ab46',
     armv7l: 'b0298ecc5c524bb7cc05b2a2905692059c9b9429a108a9dab4f575193108ab46',
       i686: 'e8d53caff67eb8aab49295ad3d0ca5fa5db0667b41e5c3aabcbea16976d7a3d0',
     x86_64: 'ed45997b1876d2f6fdc4be392d3a6f3e04eb61b05b6532bc019f4ec9f3710641'
  })

  depends_on 'python3' => :logical

  no_source_build
end
