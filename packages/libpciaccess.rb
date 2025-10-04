require 'buildsystems/meson'

class Libpciaccess < Meson
  description 'Generic PCI access library'
  homepage 'https://x.org/wiki/'
  version '0.18.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libpciaccess.git'
  git_hashtag "libpciaccess-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c8d971346ea24e2f5bc14de9070e17151943953dbf7efa515b4fb6708a723a5',
     armv7l: '5c8d971346ea24e2f5bc14de9070e17151943953dbf7efa515b4fb6708a723a5',
       i686: '9362cd9b579036b25d29082dc007539145548a6e74db327c18bc805a25d8a875',
     x86_64: 'e61aaa65adb6f1932bc538ed7bb946aec5b6502149931461dec1b9fbf7a58908'
  })

  depends_on 'glibc' # R
end
