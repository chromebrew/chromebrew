require 'buildsystems/cmake'

class Ettercap < CMake
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.5.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Ettercap/ettercap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a2c646b15e5eae1ebe2b6f73075b5f2b82ca7c3f5a335e58f4934bb6e49866f',
     armv7l: '2a2c646b15e5eae1ebe2b6f73075b5f2b82ca7c3f5a335e58f4934bb6e49866f',
       i686: '53a1a99f7a03cb9f88f10ccaf9e9eec5d9f9671afe4731bbab558dc6a4b1392d',
     x86_64: '011d8163cd4acee2f51e61670747e78eafd2144bb4d3e277b64c7fda5f84e3d0'
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
