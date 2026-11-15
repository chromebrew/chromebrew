require 'buildsystems/meson'

class Janet < Meson
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.43.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/janet-lang/janet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5d9bc76e353d1d3accd5bb61a547a9938184c5c6670cc80f29e283f8751c52b',
     armv7l: 'a5d9bc76e353d1d3accd5bb61a547a9938184c5c6670cc80f29e283f8751c52b',
       i686: 'f0bbdc7a42db6cddb730c703df21f90b8710da97ba91226242b4c703803fd702',
     x86_64: 'b162a5473eef2e6937d941037f77ad96c2f88b7e51d90fba10212a2e84963111'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dos_name=ChromeOS -Dprf=true -Dreduced_os=true'
end
