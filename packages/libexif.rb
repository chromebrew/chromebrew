require 'buildsystems/autotools'

class Libexif < Autotools
  description 'A library for parsing, editing, and saving EXIF data'
  homepage 'https://libexif.github.io/'
  version '0.6.25'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/libexif/libexif/releases/download/v#{version}/libexif-#{version}.tar.xz"
  source_sha256 '62f74cf3bf673a6e24d2de68f6741643718541f83aca5947e76e3978c25dce83'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4294ea1bb5c87281c0033466c28213309c29888b7b38dc31ca7952399eb05bf1',
     armv7l: '4294ea1bb5c87281c0033466c28213309c29888b7b38dc31ca7952399eb05bf1',
       i686: '211b09d43a3020bf1cdcb2d2717c5726e16f1e484c7f9df4d8033ece6d7f6f83',
     x86_64: 'd8d0f76f087122ac63d088ec1233e45f6b88880f80ab08bea72f2461bd4e2aa4'
  })

  depends_on 'glibc' # R
end
