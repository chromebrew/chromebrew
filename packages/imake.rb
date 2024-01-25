require 'buildsystems/autotools'

class Imake < Autotools
  description 'A build automation system written for the X Window System.'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.10'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/imake-1.0.10.tar.xz'
  source_sha256 '75decbcea8d7b354cf36adc9675e53c4790ee3de56a14bd87b42c8e8aad2ecf5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8ff6d0e9a56f8bb730bce9a966b0403cd9b4418cb793f716b30b167590d0009',
     armv7l: 'e8ff6d0e9a56f8bb730bce9a966b0403cd9b4418cb793f716b30b167590d0009',
       i686: '5360565b8f907486945ab562c7ee77265aea78ebcb2c0e1ed0ccdc6f36968449',
     x86_64: '783c7b1402a4602240421e92ca2a8131d691b874c45c5dbc219ec3ef5d0e967c'
  })

  depends_on 'xorg_cf_files'
  depends_on 'xorg_proto'

  configure_options "--sysconfdir=#{CREW_PREFIX}/etc"
end
