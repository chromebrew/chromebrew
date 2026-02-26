require 'buildsystems/meson'

class Lutris < Meson
  description 'Desktop client to play all your games on Linux'
  homepage 'https://lutris.net/'
  version '0.5.22'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/lutris/lutris.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c894663e9168aae73d8279d6fb65bb7b7788c9a3b7cd6e8e049a365214451bef',
     armv7l: 'c894663e9168aae73d8279d6fb65bb7b7788c9a3b7cd6e8e049a365214451bef',
     x86_64: '3a13f6a6da097d23413594b7c9d02a0d92d2ed288e7b33cdabd13c35a6b26e72'
  })

  depends_on 'appstream_glib' # R
  depends_on 'cabextract' # R
  depends_on 'curl' # R
  depends_on 'desktop_file_utils' # R
  depends_on 'gettext' # R
  depends_on 'mesa_utils' # R
  depends_on 'p7zip' # R
  depends_on 'pciutils' # R
  depends_on 'psmisc' # R
  depends_on 'py3_dbus_python' # R
  depends_on 'py3_pillow' # R
  depends_on 'py3_pycairo' # R
  depends_on 'py3_pygobject' # R
  depends_on 'py3_pyyaml' # R
  depends_on 'sommelier' => :logical
  depends_on 'vulkan_headers' # R
  depends_on 'vulkan_tools' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'wine' if ARCH.include?('x86_64') # R
  depends_on 'xrandr' # R

  no_shrink

  def self.postinstall
    ExitMessage.add "\nType 'lutris' to get started.\n"
  end

  def self.postremove
    puts 'WARNING: This will remove all your games!'.orange
    Package.agree_to_remove("#{HOME}/Games")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/.local/share/lutris")
  end
end
