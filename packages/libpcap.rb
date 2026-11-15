require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.11.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f043ccad3f8e8f7e36ec5d3e684365d36c3f7cc7b38004256d6187201fba6014',
     armv7l: 'f043ccad3f8e8f7e36ec5d3e684365d36c3f7cc7b38004256d6187201fba6014',
       i686: 'f1844604637787488c75884862178c7c40e286f65234710a70043dc8abefc14f',
     x86_64: '736ddb8d473db7cc20e2c31b5dd2f8d07dcb93f41b4c0777fa43a913b1925875'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libnl3' => :library
end
