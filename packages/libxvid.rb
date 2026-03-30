require 'buildsystems/autotools'

class Libxvid < Autotools
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.7'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.xvid.com/downloads/xvidcore-#{version}.tar.bz2"
  source_sha256 'aeeaae952d4db395249839a3bd03841d6844843f5a4f84c271ff88f7aa1acff7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b27cd16aab5f20218d5560d91ed39589771c77ae7ef0c25de9a4a3d477393fc',
     armv7l: '2b27cd16aab5f20218d5560d91ed39589771c77ae7ef0c25de9a4a3d477393fc',
       i686: '0d3d5f7233268a1c187141e20dafe370ccf176048becc7972bfdfa2843436758',
     x86_64: 'e6eeb1052e11ad481cd50fe54b6669d23555b94fd34f23d7e8ff6ec99ff86bd3'
  })

  depends_on 'glibc' => :library
  depends_on 'yasm' => :build

  autotools_pre_configure_options 'CFLAGS=-std=c99'
  autotools_build_relative_dir 'build/generic'
end
