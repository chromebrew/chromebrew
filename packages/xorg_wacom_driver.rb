require 'buildsystems/autotools'

class Xorg_wacom_driver < Autotools
  description 'The Xorg Wacom Driver package contains the X.Org X11 driver and SDK for Wacom and Wacom-like tablets. It is not required to use a Wacom tablet, the xf86-input-evdev driver can handle these devices without problems.'
  homepage 'https://www.x.org/wiki/'
  version '1.2.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/linuxwacom/xf86-input-wacom.git'
  git_hashtag "xf86-input-wacom-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95560ba7c87f83e3ee6697696a3c4350965495095159c4fe396f2691a447a3d9',
     armv7l: '95560ba7c87f83e3ee6697696a3c4350965495095159c4fe396f2691a447a3d9',
     x86_64: '8ef34038583b702e328ef78b70a6378fedd7ba51099860989de712a2ab95bcee'
  })

  depends_on 'eudev' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'libxi' => :executable
  depends_on 'libxinerama' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'xorg_server' => :build

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end

  run_tests
end
