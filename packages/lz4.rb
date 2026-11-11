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
    aarch64: 'f53be4b1b0091de1f4f4dd32978f15575405213d5f92ffd47e7894d4ca2c4028',
     armv7l: 'f53be4b1b0091de1f4f4dd32978f15575405213d5f92ffd47e7894d4ca2c4028',
       i686: '349ed4bcf0b390e6c243312378454bedb7c3844c3a6a0108d7bff2aebf8b45ce',
     x86_64: '543b3181a9946d535e0afa57c2041480a717cab3b0597c35f1e32f0d2026d79f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dprograms=true'

  meson_build_relative_dir 'build/meson'
end
