require 'buildsystems/meson'

class Gnome_calculator < Meson
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  version '46.rc'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82d67a2384b1e6765c69f5bd745059ee875a0e379789939e11a58c0233531bdc',
     armv7l: '82d67a2384b1e6765c69f5bd745059ee875a0e379789939e11a58c0233531bdc',
     x86_64: '38498259c4dd6b93519602c295304c110d01b8317bb6ad4f69c8ec40c180bc3e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_text_editor' # R
  depends_on 'gtk4' # R
  depends_on 'gtksourceview_5' # R
  depends_on 'itstool' => :build
  depends_on 'libadwaita' # R
  depends_on 'libgee' # R
  depends_on 'libhandy' => :build
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'py3_libxml2' => :build
  depends_on 'python3' => :build
  depends_on 'wayland' => :build

  gnome

  def self.postinstall
    puts <<~EOT.lightblue

      To use the graphical calculator, execute 'gnome-calculator'

      To use the command line calculator, execute 'gcalccmd'
    EOT
  end
end
