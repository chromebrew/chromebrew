require 'buildsystems/cmake'

class Sngrep < CMake
  description 'An Ncurses SIP Messages flow viewer'
  homepage 'https://github.com/irontec/sngrep'
  version '1.8.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/irontec/sngrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '552cc7ce41179cf9668968fae9b13f1554428246eb941c2b8fa3918396c72cd0',
     armv7l: '552cc7ce41179cf9668968fae9b13f1554428246eb941c2b8fa3918396c72cd0',
       i686: '356406691634070b953d40fbe9d3f654e672b585e9106c90e028c6ebcb3c9e2f',
     x86_64: 'a0f58ac482e37ad2f71eb0345df75f340b9725eeb6a48ad0537bbdc26e4da259'
  })

  depends_on 'libpcap'
  depends_on 'ncurses'
  depends_on 'openssl'
  depends_on 'pcre2'

  cmake_options '-DWITH_OPENSSL=ON -DWITH_PCRE2=ON -DUSE_IPV6=ON -DDISABLE_LOGO=ON'
end
