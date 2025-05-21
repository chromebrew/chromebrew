require 'buildsystems/autotools'

class Nasm < Autotools
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '2.16.03'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/netwide-assembler/nasm.git'
  git_hashtag "nasm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4204ae6b77ec62351c6e2df2b0f3cb508bbed8eaa2801fd51b0a5841048834ed',
     armv7l: '4204ae6b77ec62351c6e2df2b0f3cb508bbed8eaa2801fd51b0a5841048834ed',
       i686: 'f3a19c92edae475b96484e5baeb2213325a7bac352301f93b9c726e918188015',
     x86_64: 'eeeeff278664d40c21fb4a06ef6157fc8e7bdfd7503fc66db840b1557c3ef779'
  })

  depends_on 'py3_asciidoc' => :build
  depends_on 'xmlto' => :build

  configure_build_extras do
    system 'make manpages'
  end
end
