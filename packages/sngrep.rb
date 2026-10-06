require 'buildsystems/cmake'

class Sngrep < CMake
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.9.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c083ed097fbf39b6fcb72820c5d800463f8b3e56034744fdb41983c49badfd9',
     armv7l: '9c083ed097fbf39b6fcb72820c5d800463f8b3e56034744fdb41983c49badfd9',
       i686: '13b85edd479635b62c87c786154b28b51330a30927b0cec9bd2bb15438681b5b',
     x86_64: '5db703d03d695ba53ecef029985ee15e3a0cf4b7ae001a70344b39b36b18e309'
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
