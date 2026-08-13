require 'buildsystems/meson'

class Terminology < Meson
  description 'Enlightenments terminal emulator'
  homepage 'https://www.enlightenment.org'
  version '1.14.0'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.enlightenment.org/rel/apps/terminology/terminology-#{version}.tar.xz"
  source_sha256 'f354057051b05cffb699e33836a1135db1d4ed8bf954f9b57dc0e93bc307514d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f3435482057d9d1f8fcb10ff232dadd514e109e51f737c49434cb8ffa993cb7',
     armv7l: '8f3435482057d9d1f8fcb10ff232dadd514e109e51f737c49434cb8ffa993cb7',
     x86_64: 'bb0c3c5831b99838c914d05c212c36554bd6bcaba45c29487a56169c182f5da3'
  })

  depends_on 'desktop_file_utilities' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libefl' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'xdg_utils' => :logical
end
