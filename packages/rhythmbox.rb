require 'buildsystems/autotools'

class Rhythmbox < Autotools
  description 'Rhythmbox is a music playing application for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Rhythmbox'
  version '3.4.7'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/rhythmbox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '678900ce7386040ee771131b633252a873c78f3e65d028a0bc89e52ab25960b3',
     armv7l: '678900ce7386040ee771131b633252a873c78f3e65d028a0bc89e52ab25960b3',
     x86_64: '36c0657e604a4692c3a5a672e4f45b64ce3b275a58116e72269f68cb68677b63'
  })

  depends_on 'gtk3' => :build
  depends_on 'gst_plugins_base' => :build
  depends_on 'libpeas' => :build
  depends_on 'totem_pl_parser' => :build
  depends_on 'sommelier' => :build

  gnome

  def self.postinstall
    ExitMessage.add "Type 'rhythmbox' to get started.".lightblue
  end
end
