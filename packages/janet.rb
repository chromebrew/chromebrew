require 'buildsystems/meson'

class Janet < Meson
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.42.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/janet-lang/janet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ea88c2b4cce590dbe409a1e52ae21f36ae4462470c11b449de4a1563356f755',
     armv7l: '5ea88c2b4cce590dbe409a1e52ae21f36ae4462470c11b449de4a1563356f755',
       i686: '47d71dfe0bd31bd516c5695e9cf159e6528bde8db64854e48046111dad656268',
     x86_64: '32fb4c5726346d2eaa6058417c6d6d211d5872932c062b79033617b429b1b67a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dos_name=ChromeOS -Dprf=true -Dreduced_os=true'
end
