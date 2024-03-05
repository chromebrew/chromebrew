require 'buildsystems/meson'

class Mm_common < Meson
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  version '1.0.6'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8b0fbe6c4799067b98692ed83037174fbd80c2f8c6d3221ce80ceda1a8dacf2',
     armv7l: 'f8b0fbe6c4799067b98692ed83037174fbd80c2f8c6d3221ce80ceda1a8dacf2',
     x86_64: 'e9d214226761bd729f5a26d875c217973c53336f48c9028d962bfff5e79845fe'
  })

  meson_options '-Duse-network=true'
end
