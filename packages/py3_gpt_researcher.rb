require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.17.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a71fa6f11b79d74406226efe1b8a9866bc95620bdbd600fb8c4fbfb949bb9280',
     armv7l: 'a71fa6f11b79d74406226efe1b8a9866bc95620bdbd600fb8c4fbfb949bb9280',
     x86_64: '5e7fc24585af747af039ec7d1dde05f7261d68598eaae0ee2e2adfc5e1a82be8'
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
