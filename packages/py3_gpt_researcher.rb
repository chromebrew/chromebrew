require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.16.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05100f93c6bc12768258131c8ed7712195344d8233e62df8fe8d0a8e10d97dc8',
     armv7l: '05100f93c6bc12768258131c8ed7712195344d8233e62df8fe8d0a8e10d97dc8',
     x86_64: '6bc9be1eff4934679cf030667d1e8587a920366a041fe5c9679ef969d64ec2b3'
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
