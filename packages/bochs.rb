require 'buildsystems/autotools'

class Bochs < Autotools
  description 'Bochs is a highly portable open source IA-32 (x86) PC emulator written in C++, that runs on most popular platforms.'
  homepage 'https://bochs.sourceforge.io/'
  version '3.0'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/bochs/bochs/#{version}/bochs-#{version}.tar.gz"
  git_hashtag 'be5efebaadeb95be57d5435468bd3ec0f3007683'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6af2ef92384cd8b972f94eee7950e3af00c3230f28de00f5f0d2a485a3cfe59',
     armv7l: 'd6af2ef92384cd8b972f94eee7950e3af00c3230f28de00f5f0d2a485a3cfe59',
     x86_64: 'd5d00584c5bcb4eb1d0f6cdc09d8961a919376d4b4e7d9a118795d06e274d5e0'
  })

  depends_on 'acpica' => :executable if ARCH.eql?('x86_64')
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxpm' => :executable
  depends_on 'libxrandr' => :executable
end
