# Adapted from Arch Linux blueprint-compiler PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/blueprint-compiler/trunk/PKGBUILD

require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/'
  version '0.18.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/jwestman/blueprint-compiler.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0d0424001a8e84f6091d5dee326631e5729508bffdf3514eb2d25a2951b157a',
     armv7l: 'c0d0424001a8e84f6091d5dee326631e5729508bffdf3514eb2d25a2951b157a',
     x86_64: 'ddcc11cf462dd9c000ca6cf73c09ff86b3047270e4bbbb24d3908f5b2c06bdda'
  })

  depends_on 'py3_pygobject' => :build
end
