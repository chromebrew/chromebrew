require 'buildsystems/autotools'

class Nasm < Autotools
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '3.01'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/netwide-assembler/nasm.git'
  git_hashtag "nasm-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '981ea5b6b4422e2ea8474f7826b6dc40b7763c486a673c8e00647c7e67b1d31f',
     armv7l: '981ea5b6b4422e2ea8474f7826b6dc40b7763c486a673c8e00647c7e67b1d31f',
       i686: '14374c8074bb89ff97560e275c4b3bfff9bb285dd8041f58747b12dfb98c0b78',
     x86_64: '907797c0e510b684488ade6f22c80e346352142cc66a5fe98a8559cfbd7812f9'
  })

  depends_on 'glibc' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'xmlto' => :build

  autotools_build_extras do
    system 'make manpages'
  end
end
