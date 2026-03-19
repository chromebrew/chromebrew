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
    aarch64: '047e6e2bc4396bbf63e561650669259bdd157f58e88a565a55e730096e66d460',
     armv7l: '047e6e2bc4396bbf63e561650669259bdd157f58e88a565a55e730096e66d460',
       i686: '25b62a9151348f0e843961ce7df04869977ec56b4deab772a5d81d2dffab76bf',
     x86_64: 'c9841dbdf5f864843d7b6ed513e8776c072973e8698944f853ceae07643f7312'
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
