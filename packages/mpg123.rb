require 'buildsystems/autotools'

class Mpg123 < Autotools
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.32.3'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://sourceforge.net/projects/mpg123/files/mpg123/1.32.3/mpg123-1.32.3.tar.bz2'
  source_sha256 '2d9913a57d4ee8f497a182c6e82582602409782a4fb481e989feebf4435867b4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_armv7l/mpg123-1.32.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_armv7l/mpg123-1.32.3-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_x86_64/mpg123-1.32.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ee23b78dee236ceea6eb9b8ea8b73121054e78fbbf3e5eec2ccda354a46a0aa',
     armv7l: '1ee23b78dee236ceea6eb9b8ea8b73121054e78fbbf3e5eec2ccda354a46a0aa',
     x86_64: '190163428312dc5dd4f5ac4c076753f7b43c563f1e702d6c508467d850e0cc11'
  })

  depends_on 'alsa_lib'
  # depends_on 'cras'
  depends_on 'glibc' # R

  configure_options '--with-audio=alsa'
end
