require 'buildsystems/autotools'

class Xorg_synaptics_driver < Autotools
  description 'The Xorg Synaptics Driver package contains the X.Org Input Driver, support programs and SDK for Synaptics touchpads.'
  homepage 'https://www.x.org/wiki/'
  version '1.10.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-synaptics.git'
  git_hashtag "xf86-input-synaptics-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8000651be0f3fb1f49d331ba6149e773ab7ca0125f4c76ef7f7c7b6435d988dc',
     armv7l: '8000651be0f3fb1f49d331ba6149e773ab7ca0125f4c76ef7f7c7b6435d988dc',
     x86_64: '2e01d4d4d92920684d241cbef3b3dea34a06041060bcbd7f7203008d72814c51'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libevdev' => :library
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'libxi' => :executable
  depends_on 'xorg_server' => :build
end
