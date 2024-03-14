require 'buildsystems/meson'

class Gcab < Meson
  description 'A GObject library to create cabinet files'
  homepage 'https://gitlab.gnome.org/GNOME/gcab'
  version '1.5-ad0baea'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gcab.git'
  git_hashtag 'ad0baea50359c1978a9224ee60bf98d97bfb991f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bea55bbd954784c096f90b05e62d8b9de79fb8e0ccefdb5dcadad3f54a3f1037',
     armv7l: 'bea55bbd954784c096f90b05e62d8b9de79fb8e0ccefdb5dcadad3f54a3f1037',
       i686: '83da57fe5363d0b06c110da0546c37c8e4d5ee1146a97f2b59681a889c29157f',
     x86_64: '98cfe025afd70b829e4780c2a959764a325e7e66874068e12e0c7dab03084686'
  })

  depends_on 'gobject_introspection'
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  gnome

  def self.patch
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  meson_options '-Ddocs=false \
      -Dtests=false \
      -Dvapi=false'
end
