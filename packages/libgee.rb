require 'buildsystems/autotools'

class Libgee < Autotools
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.20.6'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/libgee.git"
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
     armv7l: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
     x86_64: '6fbb91042ade5d1fe01e47e87599a883e75f7b7d26304b0e4788684de47f8993'
  })

  depends_on 'gobject_introspection' => :build

  git_fetchtags
  gnome

  def self.patch
    system 'aclocal --install --force'
    system 'NOCONFIGURE=1 ./autogen.sh'
  end

end
