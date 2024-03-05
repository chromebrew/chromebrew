require 'buildsystems/meson'

class Atkmm < Meson
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.36.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '049d1efb8c411ac36328983605a54d54e3bc45587aa3ac9157f4b629be75f720',
     armv7l: '049d1efb8c411ac36328983605a54d54e3bc45587aa3ac9157f4b629be75f720',
       i686: '4ceaac05ebc9ae13009b10103249356131e260b7ce8ed3a3e57ad91f73f174e2',
     x86_64: 'ffe420ab3a9f104326cdb232bf5326767b07e4b5ecbc9af73909e53692b5c685'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus3' # R

  meson_options '-Dbuild-documentation=false'
end
