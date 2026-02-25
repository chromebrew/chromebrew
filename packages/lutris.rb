require 'buildsystems/meson'

class Lutris < Meson
  description 'Desktop client to play all your games on Linux'
  homepage 'https://lutris.net/'
  version '0.5.21'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/lutris/lutris.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3df92fac6ce93f046a9ad69d00084ec020d6296458962b521f511f52c81f5441',
     armv7l: '3df92fac6ce93f046a9ad69d00084ec020d6296458962b521f511f52c81f5441',
     x86_64: '2554fe5c57004148c25b19b3fdbfacd3f8e2a4088ee1a82ed528cd402eb3cb20'
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
