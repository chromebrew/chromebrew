require 'buildsystems/autotools'

class Libgee < Autotools
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.20.6'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgee.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0640bc60d3abf147de56f30c728ef8f6bf85f10be79f42107c6c30c34672d597',
     armv7l: '0640bc60d3abf147de56f30c728ef8f6bf85f10be79f42107c6c30c34672d597',
     x86_64: 'afd8b8d1dd1286486ede6bc1e70a1aee9fb48e03ba156e6040d2a2bed93df4c3'
  })

  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  git_fetchtags
  gnome

  def self.patch
    system "sed -i '/GOBJECT_INTROSPECTION/d' configure.ac"
    system "sed -i '/^if\ HAVE_INTROSPECTION/,/^endif/d' gee/Makefile.am"
    system 'NOCONFIGURE=1 ./autogen.sh'
  end
end
