require 'buildsystems/pip'

class Py3_gpt_researcher < Pip
  description 'LLM based autonomous agent that conducts deep local and web research on any topic and generates a long report with citations.'
  homepage 'https://gptr.dev/'
  version "0.14.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25974e63f145c719db4482024036ef10cad4ad92bb72504d728555cd346f3b86',
     armv7l: '25974e63f145c719db4482024036ef10cad4ad92bb72504d728555cd346f3b86',
       i686: '0f7adeca7bd53900c4ff9ed394b00acb20a8a9fdaad0216f492eca0478f3dd8e',
     x86_64: '65471b0ba28790f677b701e6b44fe735e768ba2087d5b3a35fb194a8a97e45d7'
  })

  depends_on 'llvm_dev' => build
  depends_on 'py3_maturin' => :build
  depends_on 'py3_pillow' => :build
  depends_on 'py3_pypdf' => :build
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
