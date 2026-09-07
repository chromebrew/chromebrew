require 'buildsystems/autotools'

class Lnav < Autotools
  description 'An advanced log file viewer for the small-scale'
  homepage 'https://lnav.org/'
  version '0.14.1'
  license 'BSD-2 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/tstack/lnav.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'f9f3a91883bed9a0a855f7ef7944daacd0fc5ec5a530db24963b32c8ee70d411'
  })

  depends_on 'bzip2' => :executable
  depends_on 'curl' => :executable
  depends_on 'gcc' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libarchive' => :executable
  depends_on 'libcurl' => :build
  depends_on 'libunistring' => :executable
  depends_on 'ncurses' => :build
  depends_on 'pcre2' => :executable
  depends_on 'readline' => :build
  depends_on 'sqlite' => :executable
  depends_on 'wireshark' => :build
  depends_on 'zlib' => :executable
end
