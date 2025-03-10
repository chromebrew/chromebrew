require 'buildsystems/meson'

class Lutris < Meson
  description 'Desktop client to play all your games on Linux'
  homepage 'https://lutris.net/'
  version '0.5.19'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/lutris/lutris.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f546417296a2a142f4311b15945a52acdf28b23e63e9969f9e719a7a0d0c592',
     armv7l: '7f546417296a2a142f4311b15945a52acdf28b23e63e9969f9e719a7a0d0c592',
     x86_64: '895c325a3c6903240a695d2214cb37e5c084630812ad0b3453e9af728b4121a1'
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
  depends_on 'sommelier' # R
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
