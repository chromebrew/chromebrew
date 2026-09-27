require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.16.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc312eaf2a4ccee7005757dbe0de734b4726761a19b4810cc035602aa826455b',
     armv7l: 'dc312eaf2a4ccee7005757dbe0de734b4726761a19b4810cc035602aa826455b',
     x86_64: '7f0966640a89aefc2061bea98261d68d1d98e78565826496285488afcb876ee9'
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
