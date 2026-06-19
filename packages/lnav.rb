require 'buildsystems/autotools'

class Lnav < Autotools
  description 'An advanced log file viewer for the small-scale'
  homepage 'https://lnav.org/'
  version '0.14.0'
  license 'BSD-2 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/tstack/lnav.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'd643e8c4cb58ae54054f52165a66a124c641867b0a42549688a499d93037d30b'
  })

  depends_on 'bzip2' => :executable
  depends_on 'curl' => :executable
  depends_on 'gcc' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libarchive' => :executable
  depends_on 'libcurl' => :library
  depends_on 'libunistring' => :executable
  depends_on 'ncurses' => :library
  depends_on 'pcre2' => :executable
  depends_on 'readline' => :library
  depends_on 'sqlite' => :executable
  depends_on 'wireshark' => :library
  depends_on 'zlib' => :executable
end
