require 'buildsystems/cmake'

class Ettercap < CMake
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.4'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Ettercap/ettercap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e777dff6d81b611460dfaded82b8091b38e091c2feb5056536121535f86f045f',
     armv7l: 'e777dff6d81b611460dfaded82b8091b38e091c2feb5056536121535f86f045f',
       i686: 'd7c1019cc15151b200797f88d915f0877881c32408ae89efb7f4c304f137438c',
     x86_64: 'e24fe09a30a95396459a131d4e8e90965551572110318f8b4708789ebebba209'
  })

  depends_on 'check' => :build
  depends_on 'curl' => :build
  depends_on 'libbsd'
  depends_on 'libmaxminddb'
  depends_on 'libnet'
  depends_on 'libpcap'
  depends_on 'ncurses'
  depends_on 'openssl'
  depends_on 'pcre'
  depends_on 'zlib'

  cmake_options '-DENABLE_GTK=OFF -DENABLE_TESTS=ON -DENABLE_IPV6=ON'

  run_tests
end
