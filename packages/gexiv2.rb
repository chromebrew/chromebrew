require 'buildsystems/meson'

class Gexiv2 < Meson
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.14.7'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gexiv2.git'
  git_hashtag "gexiv2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13d4fcf67d4093eb6b958f1d5b36c4a971a1c311dac245408570583978acaa4e',
     armv7l: '13d4fcf67d4093eb6b958f1d5b36c4a971a1c311dac245408570583978acaa4e',
     x86_64: 'd80f8423ee50874498dd501a618b3084bcac632668b4d543607fd522f2da3e5d'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'libexiv2' => :library

  gnome
end
