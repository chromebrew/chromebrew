# Adapted from Arch Linux sratom PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sratom/trunk/PKGBUILD

require 'buildsystems/meson'

class Sratom < Meson
  description 'An LV2 Atom RDF serialisation library'
  homepage 'https://drobilla.net/software/sratom/'
  version '0.6.14'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/lv2/sratom.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.14_armv7l/sratom-0.6.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.14_armv7l/sratom-0.6.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.14_i686/sratom-0.6.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.14_x86_64/sratom-0.6.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a241eab0e75c3e2ee29821ced0df0871384d77a901c331dcf75881114a76db8',
     armv7l: '4a241eab0e75c3e2ee29821ced0df0871384d77a901c331dcf75881114a76db8',
       i686: '1ee7375c5ee4a22fc0db8d537e3242e33138f1ef0b77427d1597a4d74844d58d',
     x86_64: '0e47e2f1d4880e7fd301b53e40507b58510dd1cac83cef8869ce96caf0bba0b3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'serd' # R
  depends_on 'sord' # R

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
