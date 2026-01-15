require 'buildsystems/meson'

class Gnome_calculator < Meson
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  version '49.2'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54291f6315978b770b449cca3acd3525cc8da8a0526e2344ba73300f6daea131',
     armv7l: '54291f6315978b770b449cca3acd3525cc8da8a0526e2344ba73300f6daea131',
     x86_64: 'd6a6c62ffcff637fe5ea2e90328ba798856041a4885ec75c53db9b227308ed6d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'gtksourceview_5' # R
  depends_on 'libadwaita' # R
  depends_on 'libgee' # R
  depends_on 'libhandy' => :build
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'python3' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build

  gnome

  def self.postinstall
    puts <<~EOT.lightblue

      To use the graphical calculator, execute 'gnome-calculator'

      To use the command line calculator, execute 'gcalccmd'
    EOT
  end
end
