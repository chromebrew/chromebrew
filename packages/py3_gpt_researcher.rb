require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.14.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6083f4d0806c9d335948165f38a0bfb17cf45f42f4ba9168806883dff5bb90c7',
     armv7l: '6083f4d0806c9d335948165f38a0bfb17cf45f42f4ba9168806883dff5bb90c7',
     x86_64: '0f8c41d5c09bdec7aaac346b74460f9697611227cdff2f4e84d8b1e96719a614'
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
