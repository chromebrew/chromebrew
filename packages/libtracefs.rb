require 'buildsystems/meson'

class Libtracefs < Meson
  description 'Trace filesystem events in the Linux kernel'
  homepage 'https://github.com/rostedt/libtracefs'
  version '24f4399'
  license 'GPL-2.0, LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/rostedt/libtracefs.git'
  git_hashtag '24f43996abb31c9064f98cd4fc93c25e57033cb5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b27acc8e46e01eac2bc732aa5a51ffd4475a3f6110163d9d35646a334882d47',
     armv7l: '2b27acc8e46e01eac2bc732aa5a51ffd4475a3f6110163d9d35646a334882d47',
     x86_64: '78d813c4b99ffec43de8007ae2d8669fe78534e3da1237809703f6184adb436f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libtraceevent' => :library
  depends_on 'py3_asciidoc' => :build
end
