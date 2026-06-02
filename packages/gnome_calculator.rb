require 'buildsystems/meson'

class Gnome_calculator < Meson
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  version '50.0'
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

  binary_sha256({
    aarch64: '54291f6315978b770b449cca3acd3525cc8da8a0526e2344ba73300f6daea131',
     armv7l: '54291f6315978b770b449cca3acd3525cc8da8a0526e2344ba73300f6daea131',
     x86_64: '989910832901867cfb0a0baf96450e305c6663ac0a6bd830dc9b28a1e2b160cc'
  })

  depends_on 'blueprint_compiler' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk4' => :library
  depends_on 'gtksourceview_5' => :executable
  depends_on 'libadwaita' => :executable
  depends_on 'libgee' => :library
  depends_on 'libhandy' => :build
  depends_on 'libsoup' => :executable
  depends_on 'libsoup' => :library
  depends_on 'libxml2' => :executable
  depends_on 'libxml2' => :library
  depends_on 'mpc' => :library
  depends_on 'mpfr' => :library
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
