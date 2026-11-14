require 'buildsystems/meson'

class Libtraceevent < Meson
  description 'Trace events in the Linux kernel'
  homepage 'https://github.com/rostedt/libtraceevent'
  version '51d47b0'
  license 'GPL-2.0, LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/rostedt/libtraceevent.git'
  git_hashtag '51d47b0eb2b40d4273fb461782fe9a01db0f901c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0685dcd1e44ca1587a96dd4c4a9b72a52471d6c21971343a9e29f641f0ee94a7',
     armv7l: '0685dcd1e44ca1587a96dd4c4a9b72a52471d6c21971343a9e29f641f0ee94a7',
     x86_64: '83b5b29b444da854ea80bf1bb386d9f230387c1b015b1a1b68393b393338bbe2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_asciidoc' => :build
end
