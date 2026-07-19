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
    aarch64: '81e78a9f6dfc5bfc8aa44b725b93690383e59fdce8a46f8d50a8cd92c0abb3f5',
     armv7l: '81e78a9f6dfc5bfc8aa44b725b93690383e59fdce8a46f8d50a8cd92c0abb3f5',
     x86_64: 'a42e2bc2963c12c7d2bd5bc84033530744d365fe70d66817b992b30fab082e2e'
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
