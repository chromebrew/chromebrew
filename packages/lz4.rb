require 'buildsystems/meson'

class Lz4 < Meson
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.org/'
  version '1.11.1'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '163eb43ecd5c0955de31128d11ac4c7ae77d649c49c5222dbb77d74cbff90d89',
     armv7l: '163eb43ecd5c0955de31128d11ac4c7ae77d649c49c5222dbb77d74cbff90d89',
       i686: '9a14b63419ae37b5396c58127dcd3b869f5a13495f1cc5b0f539e98481d6be6e',
     x86_64: 'b7ec39e95d7fa1bb1db740ab3340fcbdc4186cc4f60cc2de6c33fb7bf6e312be'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dprograms=true'

  meson_build_relative_dir 'build/meson'
end
