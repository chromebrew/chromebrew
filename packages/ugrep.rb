require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '7.1.2'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'bdd68e48eeb6d26b120be3923ccbbf71523ab1ad3469020b50c85f4bc541f56b'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlib'
  depends_on 'zstd'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    system 'autoreconf -f'
  end
end
