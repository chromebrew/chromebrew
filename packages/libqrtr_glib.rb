require 'buildsystems/meson'

class Libqrtr_glib < Meson
  description 'Qualcomm IPC Router protocol helper library'
  homepage 'https://gitlab.freedesktop.org/mobile-broadband/libqrtr-glib'
  version '1.4.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mobile-broadband/libqrtr-glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a52daa921ff666851af789542f1b90d257679b55c5130e3327814f38cb0ca014',
     armv7l: 'a52daa921ff666851af789542f1b90d257679b55c5130e3327814f38cb0ca014',
     x86_64: '5187b2dd75154fe18f46f693cb327f4fefd5ec68421321a7d6195f2ae1d65eeb'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
