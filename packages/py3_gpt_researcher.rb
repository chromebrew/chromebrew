require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.14.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be223ab557e68dd7d9de8b7694e71fa94a47dd5f7862bb3a904b88187f1a8a02',
     armv7l: 'be223ab557e68dd7d9de8b7694e71fa94a47dd5f7862bb3a904b88187f1a8a02',
     x86_64: '5bd7d4f5f1fb4725b93fdcbda02e24853f39ce067a5d00478a5a62a341016c54'
  })

  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'py3_pillow' => :build
  depends_on 'py3_pypdf' => :build
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
