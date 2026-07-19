require 'buildsystems/autotools'

class Nasm < Autotools
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '3.02'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/netwide-assembler/nasm.git'
  git_hashtag "nasm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ffca80369cc4c570cb44969af4456068aa8d8613a949bc9aac12b17ae67d950',
     armv7l: '5ffca80369cc4c570cb44969af4456068aa8d8613a949bc9aac12b17ae67d950',
       i686: '2b0c7d6dd11cb97499cb63e13335ee1126be19e5907fa977dcec830ab31dc3a5',
     x86_64: '92b4f1c5fd25d9868e8108203bc6601a6abe1d2abc2be38e15042eadfab7f7b2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_asciidoc' => :build
  depends_on 'xmlto' => :build
  depends_on 'zlib' => :executable

  autotools_skip_autoreconf
  autotools_build_extras do
    system 'make manpages'
  end
end
