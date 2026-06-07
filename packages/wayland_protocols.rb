require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.49'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b2712928a2deea8e46e70a3c9d65428283672b6eb12c4b70bc622baf558f197',
     armv7l: '6b2712928a2deea8e46e70a3c9d65428283672b6eb12c4b70bc622baf558f197',
       i686: 'e6d96189e7ce151235a5340d4575b376547cbb2a6b6dc542ca54397a2fd5c0b1',
     x86_64: 'fa96efe16905d25ac3954503d8f2be908b8ab56d414ba4e6dae517fece950f21'
  })

  depends_on 'wayland' => :logical

  meson_options '-Dtests=false'
end
