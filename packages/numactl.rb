require 'buildsystems/autotools'

class Numactl < Autotools
  description 'NUMA support for Linux'
  homepage 'https://github.com/numactl/numactl'
  version '2.0.16'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/numactl/numactl/releases/download/v2.0.16/numactl-2.0.16.tar.gz'
  source_sha256 '1b242f893af977a1d31af6ce9d6b8dafdd2d8ec3dc9207f7c2dc0d3446e7c7c8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.16_armv7l/numactl-2.0.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.16_armv7l/numactl-2.0.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.16_i686/numactl-2.0.16-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.16_x86_64/numactl-2.0.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec2f974440d9ba7e9dbd5dd5b7cf4e486f4e8c5809e4a82cc109de4db8492c57',
     armv7l: 'ec2f974440d9ba7e9dbd5dd5b7cf4e486f4e8c5809e4a82cc109de4db8492c57',
       i686: 'a956f95954a63ebdaa081c44cc286a9f3d9a9e86bd0f6c7064510283c7cd39ee',
     x86_64: 'feee34c5f54f8c7cd6da4cd7350cab19f3aa66e25715be63357477e10b523769'
  })

  depends_on 'glibc' # R
  conflicts_ok # ["manpages:/usr/local/share/man/man2/move_pages.2.zst"]
end
