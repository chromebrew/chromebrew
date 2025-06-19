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
    aarch64: 'df3fd8c7a103865e06d418c222e45126c67f9429c69b328a345933f5bb5c5191',
     armv7l: 'df3fd8c7a103865e06d418c222e45126c67f9429c69b328a345933f5bb5c5191',
       i686: '211b09d43a3020bf1cdcb2d2717c5726e16f1e484c7f9df4d8033ece6d7f6f83',
     x86_64: '43f6b8797fdf74628975495ce9421cf8dd232e5d5473fae286b38ac5e47e75eb'
  })

  depends_on 'glibc' # R
end
