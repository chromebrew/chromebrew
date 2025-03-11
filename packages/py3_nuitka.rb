require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4dd79f623e82456d58bef8193417bc457b4b78de70b793009d6fd5effb6daae',
     armv7l: 'f4dd79f623e82456d58bef8193417bc457b4b78de70b793009d6fd5effb6daae',
       i686: '5d51aa42c9710652b823b903055b26ffea95f9921bfebf8b8f925b106e3a551a',
     x86_64: '0a5c915f2d2a1bd06047e5c583bec72d781cead1284d142be83bb9524b3fd558'
  })

  depends_on 'python3' => :build

  no_source_build
end
