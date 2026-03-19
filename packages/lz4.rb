require 'buildsystems/meson'

class Lz4 < Meson
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.org/'
  version '1.10.0-2'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c3cfc33448b4b1ce19536e07187b44eaa649e3f161a252957dc6fd511f3bee5',
     armv7l: '2c3cfc33448b4b1ce19536e07187b44eaa649e3f161a252957dc6fd511f3bee5',
       i686: '1c67990d04b5ac9d36331de00af4aa900bd0cb63c456e04adfe8641c1aaa9aa8',
     x86_64: 'eb0777acb53c1e81e673e87648fdae53a0a05c5e463475e688e6633c27e5b195'
  })

  depends_on 'glibc' # R

  meson_options '-Dprograms=true'

  meson_build_relative_dir 'build/meson'
end
