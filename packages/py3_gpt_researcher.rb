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
    aarch64: 'e106eb396b2b49cfad300af50f947f3a55595ed73059ee99b272b5da3ee917ec',
     armv7l: 'e106eb396b2b49cfad300af50f947f3a55595ed73059ee99b272b5da3ee917ec',
     x86_64: '9c454cb385c543e7a9fe46af80681e0e5c3a860a3adb2059755555a72cd8cbd2'
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
