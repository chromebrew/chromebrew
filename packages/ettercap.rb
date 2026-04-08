require 'buildsystems/cmake'

class Ettercap < CMake
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.4.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Ettercap/ettercap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52693ccd24eed587a1bb4fcdb464012988b6095cdb3f4d12aaed9cadf813d86d',
     armv7l: '52693ccd24eed587a1bb4fcdb464012988b6095cdb3f4d12aaed9cadf813d86d',
       i686: 'f7bffa31e8ebe205b3aba0f2b45fd590b0720394c99101d348fe41504200e796',
     x86_64: 'a1f64ec41ee31d71fd5bfbe65d536889b6ceeddad2a0bcca43b0b3df659d6dcf'
  })

  depends_on 'check' => :build
  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'libbsd' => :library
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
