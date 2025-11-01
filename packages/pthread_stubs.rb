require 'buildsystems/autotools'

class Pthread_stubs < Autotools
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org/wiki/'
  version '0.5'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/pthread-stubs.git'
  git_hashtag "libpthread-stubs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85fd777e81a2dd5e3954e82465291c2c889567b7ae8bbb7a3e51b196c8ed35dd',
     armv7l: '85fd777e81a2dd5e3954e82465291c2c889567b7ae8bbb7a3e51b196c8ed35dd',
       i686: '3fa0eb953101a37c924a22fa28699d1cb7e4a85bd79b7c492f087df91e108e42',
     x86_64: '74d475f18422369cea3e5ca5591c55aa2caaac2ad23abaf17e5678daec534cf9'
  })
end
