require 'buildsystems/autotools'

class Libpcap < Autotools
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.7'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/the-tcpdump-group/libpcap.git'
  git_hashtag "libpcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fc959573756981b75da91bf89344fbe9a380588e1ee5418d65e10c622a5c250',
     armv7l: '8fc959573756981b75da91bf89344fbe9a380588e1ee5418d65e10c622a5c250',
       i686: '438cf00b0ad5d921efb0bf04046be51c9a4dcfbebf059a5e7192e765a74d6ade',
     x86_64: '42e4ea9a790456ba2897e05ffc8a80b7f5a0fd1a251a10c845825b711552cf61'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libnl3' => :library
end
