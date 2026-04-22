require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '7.7.0'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '3a47e4719d1937fe595c9ae2147882af076dccce183053113c17afea8ad9c5aa'
  })

  depends_on 'brotli' => :executable
  depends_on 'bzip2' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'lz4' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  def self.patch
    system 'autoreconf -f'
  end
end
