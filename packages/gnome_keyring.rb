require 'buildsystems/autotools'

class Gnome_keyring < Autotools
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '46.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-keyring.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d59224375f9d0706112746e1769575009ac2c58d663aa9d92eeb32752aa6d98',
      armv7l: '6d59224375f9d0706112746e1769575009ac2c58d663aa9d92eeb32752aa6d98',
      x86_64: '9fddad7d70acf21d5a6a2700400762e5b46ebd43413be6cd2db96eba2f9c8048'
  })

  depends_on 'gcr' => :build
  depends_on 'libcap' => :build
  depends_on 'libcap_ng' => :build
  depends_on 'linux_pam' => :build
  depends_on 'dconf' => :build
  depends_on 'gcr' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'glib' => :build
  depends_on 'libxslt' => :build
  depends_on 'openssh' => :build

  gnome

  configure_options "--with-pam-dir=#{CREW_PREFIX}/lib/security \
    --disable-schemas-compile \
    --disable-doc" # Docs cannot be used due to #4275
end
