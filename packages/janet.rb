require 'buildsystems/meson'

class Janet < Meson
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.42.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/janet-lang/janet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '317da62b834de89788a67494717f3ba136d96a339c40debf4074cff278a6c86b',
     armv7l: '317da62b834de89788a67494717f3ba136d96a339c40debf4074cff278a6c86b',
       i686: '9ba377add2b822e2924e07746240451ad78a89d518443870a24693a6cb733bee',
     x86_64: 'ad3d771b7e0c9cc27f944f8e2c10e8e1240100e9d2298605fa3535378af3019a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dos_name=ChromeOS -Dprf=true -Dreduced_os=true'
end
