require 'buildsystems/autotools'

class Libgee < Autotools
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.20.8'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libgee/-/archive/#{version}/libgee-#{version}.tar.bz2"
  source_sha256 'fe3d412f206ba2603dc9f26cf14b9049d9311e745bff27bd93863c961c65f2f3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
     armv7l: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
       i686: 'eee9240a4dca8afd2393ed595384fbaef98e83a6a0e6ce8f86290265d6f62025',
     x86_64: '6fbb91042ade5d1fe01e47e87599a883e75f7b7d26304b0e4788684de47f8993'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
