require 'buildsystems/meson'

class Janet < Meson
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.43.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/janet-lang/janet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '203936fa9869821ea78e31d64d7cf60fe72803ae3efd306a76f6e20f16a75f0b',
     armv7l: '203936fa9869821ea78e31d64d7cf60fe72803ae3efd306a76f6e20f16a75f0b',
       i686: '27344920176eb68657ffae28f29207f35a92f8d36b5269dae639c42893b58958',
     x86_64: 'd2427917bc238dd1f36d405ed17978ec99e1294ab3e31beba2109ecd85c20580'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dos_name=ChromeOS -Dprf=true -Dreduced_os=true'
end
