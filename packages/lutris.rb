require 'buildsystems/meson'

class Lutris < Meson
  description 'Desktop client to play all your games on Linux'
  homepage 'https://lutris.net/'
  version '0.5.20'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/lutris/lutris.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b1dd14c0bb4ec0a94facff58b1ea0bbba6b58a08568bcaac350d8d12e540742',
     armv7l: '4b1dd14c0bb4ec0a94facff58b1ea0bbba6b58a08568bcaac350d8d12e540742',
     x86_64: '2ce7e0947481350d77f9548a4d85d0834d364f7cb61e734da8e9f2e40639627a'
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
