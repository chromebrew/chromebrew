require 'buildsystems/meson'

class Janet < Meson
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.41.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/janet-lang/janet.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47fe7ca6d9592746455e72dda55bc38df031ac082bee998587e211c0854c82ca',
     armv7l: '47fe7ca6d9592746455e72dda55bc38df031ac082bee998587e211c0854c82ca',
       i686: 'e1e5e7937d97b598e9eaa26f7345196797b9e9f2991fb756681f3a3f6c3d4785',
     x86_64: 'cc18a14abd4f1d2698d45745fefb53cb9127b130d139c01d5d7c1331626f8048'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dos_name=ChromeOS -Dprf=true -Dreduced_os=true'
end
