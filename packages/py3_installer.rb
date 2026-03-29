require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af3120cca1fad7f67b7eb183bd75a7671a9e0304df3e3c7f0a865998ba81e9e4',
     armv7l: 'af3120cca1fad7f67b7eb183bd75a7671a9e0304df3e3c7f0a865998ba81e9e4',
       i686: '76db3e8ae0b2fd08f7468a1492dbeae461ca8fcefbfa1bfe226c74f77ff342a4',
     x86_64: 'c5558bbd6fdf6b2ab50b66cebc62c493edac7c9271296018a0cea8bd6b94ad88'
  })

  depends_on 'python3' => :logical

  no_source_build
end
