require 'buildsystems/autotools'

class Daq < Autotools
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '3.0.27'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/snort3/libdaq.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '665a396c382f92e9f4f72c404dd02cc572cc555d19940f74870f89d219365e51',
     armv7l: '665a396c382f92e9f4f72c404dd02cc572cc555d19940f74870f89d219365e51',
       i686: 'd1899623019f3b89ea36662ce91e2247670d29ab93da80c1f63a3e03f0482a70',
     x86_64: 'f71eb7d7e0c8ed0db4004cb64473e7a7b2ed0a9f3de60ea898cffef66364ab60'
  })

  # depends_on 'cmocka' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libpcap' => :library

  # https://github.com/snort3/libdaq/issues/30
  # run_tests
end
