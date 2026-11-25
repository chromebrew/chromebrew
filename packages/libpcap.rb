require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.11.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed26815162645f659b6ef1813d209232f58ef36ab058c5d6450ee059ed4039e7',
     armv7l: 'ed26815162645f659b6ef1813d209232f58ef36ab058c5d6450ee059ed4039e7',
       i686: '7693587182b836f02cdec83a125f82a3f82606c3a41a94cb05bfa4e62c60d3ad',
     x86_64: 'b2f442326ac5db53fe83d0ad1520a83ef324ba23a73dae926c504799147596b4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libnl3' => :library
end
