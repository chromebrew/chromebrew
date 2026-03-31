require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '7.6.0'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'db52769d9b3f6c63584b06b498aa9bfe41e3b875b1d4032cd2e1ad902e3cac95'
  })

  depends_on 'brotli' => :executable
  depends_on 'bzip2' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'lz4' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :library
  depends_on 'zstd' => :executable

  def self.patch
    system 'autoreconf -f'
  end
end
