require 'buildsystems/cmake'

class Sngrep < CMake
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.8.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2458526e01d60bdb3683b473195d280126ff0e67def8dee06ad3a3287756389',
     armv7l: 'b2458526e01d60bdb3683b473195d280126ff0e67def8dee06ad3a3287756389',
       i686: 'e21cb11af5ff3f96a113a219297a4bde024e20b9268c4ba871edad641bf02ecb',
     x86_64: 'ce8268947e49d13ec19f3d7eaea055c303d762770fcb90430d5b429f1d5f20a5'
  })

  depends_on 'glibc' => :executable
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
