require 'buildsystems/meson'

class Atkmm < Meson
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.36.4'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c60479d42cfab2a0397b6fc4de6d9d9a31921191b953a6b732035a5c7c700c44',
     armv7l: 'c60479d42cfab2a0397b6fc4de6d9d9a31921191b953a6b732035a5c7c700c44',
     x86_64: '89ab2e70d0a18d4ba0b59780727b06e2e40b23d09bfb7bb38ec6619593fab75b'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glibmm_2_68' => :library
  depends_on 'libsigcplusplus' => :library
  depends_on 'libsigcplusplus3' => :library
  depends_on 'mm_common' => :library

  gnome

  meson_options '-Dbuild-documentation=false'
end
