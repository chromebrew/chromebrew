require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac24139c0a68ab377f2aac4de4113217280a5395b44229e892b098c245d81ef7',
     armv7l: 'ac24139c0a68ab377f2aac4de4113217280a5395b44229e892b098c245d81ef7',
       i686: '2bc39b939f1a397313e87f6c78148aa8c13fe448f1b6d93ab9ebc138e687ca2b',
     x86_64: '4725aea21a97e5d2487143edc43d3c46f25971dc147c1397e9ad4cb2099ce8ce'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
