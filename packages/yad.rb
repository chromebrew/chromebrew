require 'buildsystems/autotools'

class Yad < Autotools
  description 'display graphical dialogs from shell scripts or command line.'
  homepage 'https://github.com/v1cont/yad'
  version '14.1'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/v1cont/yad.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e95ee3627b04922ddd447649e69ea54c9dc43e7138319bd1588a4f8b58b51af',
     armv7l: '9e95ee3627b04922ddd447649e69ea54c9dc43e7138319bd1588a4f8b58b51af',
     x86_64: '1fdac4030f16b26ff16102a570c6d2ec58a5228fd8f89752e4e6da58555a6604'
  })

  depends_on 'gtk3'
  depends_on 'rgb'

  autotools_configure_options "--enable-gio \
           --enable-icon-browser \
           --with-gtk=gtk3 \
           --with-rgb=#{CREW_PREFIX}/share/X11/rgb.txt"

end
