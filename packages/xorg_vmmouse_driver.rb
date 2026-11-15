require 'buildsystems/autotools'

class Xorg_vmmouse_driver < Autotools
  description 'The Xorg VMMouse Driver package contains the VMMouse input driver for the Xorg X server. The VMMouse driver enables support for the special VMMouse protocol that is provided by VMware virtual machines to give absolute pointer positioning.'
  homepage 'https://www.x.org/wiki/'
  version '13.2.0'
  license 'MIT-with-advertising and ISC'
  compatibility 'x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-vmmouse.git'
  git_hashtag "xf86-input-vmmouse-#{version}"
  binary_compression 'tar.zst'

  depends_on 'eudev' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'xorg_server' => :build

  binary_sha256({
    x86_64: 'a8297174e6fc561619ce859a6aa2e3fc66db5cf19789661f8b94a26bd36f9a1d'
  })

  # The vmmouse protocol is only supported on x86 architectures.
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
