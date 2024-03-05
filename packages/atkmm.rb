require 'buildsystems/meson'

class Atkmm < Meson
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.36.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9224b82b6db207ebcb652edeb5403eec1be918f7b395d449c2b4a6bd04298a37',
     armv7l: '9224b82b6db207ebcb652edeb5403eec1be918f7b395d449c2b4a6bd04298a37',
       i686: '4ceaac05ebc9ae13009b10103249356131e260b7ce8ed3a3e57ad91f73f174e2',
     x86_64: 'a31362204e6e24f6f808389b62868f690b9377185c979dcbdadf737293d4c306'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus3' # R

  meson_options '-Dbuild-documentation=false'
end
