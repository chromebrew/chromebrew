require 'buildsystems/cmake'

class Sngrep < CMake
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.8.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf8a9e46bc436a1c8902545b07c2787d5668efbe55280f307c7b59a56ffa7202',
     armv7l: 'cf8a9e46bc436a1c8902545b07c2787d5668efbe55280f307c7b59a56ffa7202',
       i686: '8a814442dedb15034630a29b73b0b5b1614ea51558a282064c716edcad57d4a0',
     x86_64: '9c8f9deeeea26c0ba45bd1cb152d15b41afc2babc0ebe42368db1b8f87ea7136'
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
