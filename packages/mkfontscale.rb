require 'buildsystems/autotools'

class Mkfontscale < Autotools
  description 'X11 Scalable Font Index Generator'
  homepage 'https://www.x.org/wiki/'
  version '1.2.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://xorg.freedesktop.org/archive/individual/app/mkfontscale-#{version}.tar.xz"
  source_sha256 'a01492a17a9b6c0ee3f92ee578850e305315b9f298da5f006a1cd4b51db01a5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '901addea13358a97378dd55c3bc6d6cb41855190b3c5e08c48c4829b0dc2db40',
     armv7l: '901addea13358a97378dd55c3bc6d6cb41855190b3c5e08c48c4829b0dc2db40',
     x86_64: '1bae144c8961d56ae7f0200fe121c8f0764afc4502e891c78f1d85498ce69baa'
  })

  depends_on 'freetype' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libfontenc' => :executable
  depends_on 'xorg_proto' => :executable
  depends_on 'zlib' => :executable
end
