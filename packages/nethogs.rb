require 'buildsystems/autotools'

class Nethogs < Autotools
  description "Linux 'net top' tool"
  homepage 'https://github.com/raboof/nethogs'
  version '0.9.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/raboof/nethogs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '922510114f373f3f985b791b07c6b4399ee037277b9ad8d71ef596c441e0d73c',
     armv7l: '922510114f373f3f985b791b07c6b4399ee037277b9ad8d71ef596c441e0d73c',
       i686: 'a31ad6b573a9dd490447680c142e5d059a3b9b5fd06474d6ca82cba0b367e4f4',
     x86_64: '34b4322abac56ca8f23d250e71f875e1b0d8707e2337bcf128d7f939fdfbc8b7'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable

  autotools_skip_configure
  autotools_pre_make_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
