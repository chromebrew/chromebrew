require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.14.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48ed077b1f15eac06d7a44b8cae485a5f84e90d68ae78fca7d3882853bd2e91e',
     armv7l: '48ed077b1f15eac06d7a44b8cae485a5f84e90d68ae78fca7d3882853bd2e91e',
     x86_64: '579b16b9ca2ef3bd795e1dad4142d3f241690f2a95ce1d5cd03dabe3d38d6f13'
  })

  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'py3_pillow' => :build
  depends_on 'py3_pypdf' => :build
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
