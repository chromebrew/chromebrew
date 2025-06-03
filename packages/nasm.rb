require 'buildsystems/autotools'

class Nasm < Autotools
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '2.16.03-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/netwide-assembler/nasm.git'
  git_hashtag "nasm-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef7c0f9b1f2b348d694ab5326d9fb42eb39e48d6d762d3d839784233240d316f',
     armv7l: 'ef7c0f9b1f2b348d694ab5326d9fb42eb39e48d6d762d3d839784233240d316f',
       i686: 'deafb95a802d8c64e3495c3f3e180a76c653e5cc5940601399455bd02282da75',
     x86_64: '1aa847352074cf6f627a82385839643ce5d8b8a219e8bdb56166cf7b91e30f62'
  })

  depends_on 'glibc' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'xmlto' => :build

  autotools_build_extras do
    system 'make manpages'
  end
end
