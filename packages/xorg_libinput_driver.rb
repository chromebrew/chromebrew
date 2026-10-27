require 'buildsystems/autotools'

class Xorg_libinput_driver < Autotools
  description 'The X.Org Libinput Driver is a thin wrapper around libinput and allows for libinput to be used for input devices in X. This driver can be used as drop-in replacement for evdev and synaptics.'
  homepage 'https://www.x.org/wiki/'
  version '1.5.0'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-libinput.git'
  git_hashtag "xf86-input-libinput-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30965b8989d5fd90ad1165a0f68e104c5ba7d593858a65a20774ade5f89ad608',
     armv7l: '30965b8989d5fd90ad1165a0f68e104c5ba7d593858a65a20774ade5f89ad608',
     x86_64: 'b21e1056462c287cce5d1428091edb9995f7c6fcee0963bf75407e4f43c5567a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libinput' => :library
  depends_on 'xorg_server' => :build

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end

  run_tests
end
