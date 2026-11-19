require 'buildsystems/cmake'

class Ettercap < CMake
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.5.2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Ettercap/ettercap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eede5125c6ecfb178a8133a050c85e06576aedd6f958a64bc584f2870ecca25c',
     armv7l: 'eede5125c6ecfb178a8133a050c85e06576aedd6f958a64bc584f2870ecca25c',
       i686: 'bdd30631e3926c6a91e4d064305384f01a201b432d3bf4d272706bd9b0b7a7be',
     x86_64: '4f4210a62f12806e45759d5be2f733cc7920be0894c7118a980520f7459f7c72'
  })

  depends_on 'check' => :build
  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libiconv' => :library
  depends_on 'libmaxminddb' => :library
  depends_on 'libnet' => :library
  depends_on 'libpcap' => :library
  depends_on 'ncurses' => :library
  depends_on 'openssl' => :library
  depends_on 'pcre'
  depends_on 'pcre2' => :library
  depends_on 'zlib' => :library

  cmake_options '-DENABLE_GTK=OFF -DENABLE_TESTS=ON -DENABLE_IPV6=ON'

  run_tests
end
