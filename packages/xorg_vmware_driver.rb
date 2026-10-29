require 'buildsystems/autotools'

class Xorg_vmware_driver < Autotools
  description 'The Xorg VMware Driver package contains the X.Org Video Driver for VMware SVGA virtual video cards.'
  homepage 'https://01.org/linuxgraphics/'
  version '13.4.0'
  license 'MIT and MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-video-vmware.git'
  git_hashtag "xf86-video-vmware-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6d78445a071062f9450a6b78bf5f2bef36005a27784098f0cdfc93d7a04bc1d',
     armv7l: 'c6d78445a071062f9450a6b78bf5f2bef36005a27784098f0cdfc93d7a04bc1d',
     x86_64: '1b9be5dea73c63036f47ae7bdb84ac12f868a8d3a6fc32e6a0875acdb2f48b97'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'xorg_server' => :build

  autotools_pre_configure_options "CFLAGS+=' -Wno-implicit-function-declaration'"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
