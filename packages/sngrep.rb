require 'buildsystems/cmake'

class Sngrep < CMake
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.10.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f075905e5c2acb6a6c8c135401505bc3a382fdcae9f9be5c8fe272e71ebf7535',
     armv7l: 'f075905e5c2acb6a6c8c135401505bc3a382fdcae9f9be5c8fe272e71ebf7535',
       i686: 'e4236e04b5efdf796afafbe5cbba28427003e919a12180442897d8fe55b78fbb',
     x86_64: '758129d00aaeba0f6d9cc5a0bb346639b3ad1af2d43442d9a4f2422c4c663b6a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pcre2' => :executable

  def self.patch
    # Fix error: implicit declaration of function ‘sng_strncpy’; did you mean ‘strncpy’?
    system "find -name '*.c' -exec sed -i 's,sng_strncpy,strncpy,g' {} +"
  end

  cmake_options '-DWITH_OPENSSL=ON -DWITH_PCRE2=ON -DUSE_IPV6=ON -DDISABLE_LOGO=ON'
end
