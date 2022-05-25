require 'buildsystems/autotools'

class Mpg123 < Autotools
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.32.3'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/mpg123/files/mpg123/1.32.3/mpg123-1.32.3.tar.bz2'
  source_sha256 '2d9913a57d4ee8f497a182c6e82582602409782a4fb481e989feebf4435867b4'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_armv7l/mpg123-1.32.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_armv7l/mpg123-1.32.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_i686/mpg123-1.32.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.32.3_x86_64/mpg123-1.32.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ee23b78dee236ceea6eb9b8ea8b73121054e78fbbf3e5eec2ccda354a46a0aa',
     armv7l: '1ee23b78dee236ceea6eb9b8ea8b73121054e78fbbf3e5eec2ccda354a46a0aa',
       i686: 'b5d513cd57c46d1b5b563bb663d733696f5c521f3f4cd3349b3125a4d52b0391',
     x86_64: '190163428312dc5dd4f5ac4c076753f7b43c563f1e702d6c508467d850e0cc11'
  })

  depends_on 'alsa_lib'
  # depends_on 'cras'
  depends_on 'glibc' # R

  case ARCH
  when 'i686'
    configure_options '--with-audio=alsa --with-cpu=i386'
  else
    configure_options '--with-audio=alsa'
  end
end
