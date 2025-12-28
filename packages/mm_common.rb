require 'buildsystems/meson'

class Mm_common < Meson
  description 'Common build files of the C++ bindings'
  homepage 'https://www.gtkmm.org/'
  version '1.0.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ddca6353d6b5db344516daa86b1d49bc2a61f9431f32fcfee26ab08a85e7a0b',
     armv7l: '8ddca6353d6b5db344516daa86b1d49bc2a61f9431f32fcfee26ab08a85e7a0b',
       i686: '30f788ba6c01256bdb9f75647f2167fa942d27b799d8297ae50cd26c0c4329bf',
     x86_64: 'bea3f846e57af0a970adb5875bc9953864059e744a933ad035738d0e3b519ea7'
  })

  gnome

  meson_options '-Duse-network=true'
end
