require 'buildsystems/meson'

class Geocode_glib < Meson
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.4-1'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/geocode-glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9090dd6c6054ce951bca9256b31046730e3a379f14bc4a2f87bac265890c3cf9',
     armv7l: '9090dd6c6054ce951bca9256b31046730e3a379f14bc4a2f87bac265890c3cf9',
     x86_64: '35338e68809b3785b69e54b16d0cc9831a75c8a224a2793806ca6a4f98cc5fee'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libsoup2' # R
  depends_on 'py3_pygments' => :build

  gnome

  meson_options '-Denable-installed-tests=false -Denable-gtk-doc=false -Dsoup2=true'

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end
end
