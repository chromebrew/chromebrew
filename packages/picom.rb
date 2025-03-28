require 'package'

class Picom < Package
  description 'Lightweight compositor for X11 (previously a compton fork)'
  homepage 'https://github.com/yshui/picom/'
  version '8'
  license 'MPL-2.0 and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/yshui/picom/archive/v8.tar.gz'
  source_sha256 'f839a3c058ca90f463eae3973a9381cf2fe93be7d0e58db1c28ea72acd10480f'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5de726299cbd8469b6c846cf437aac9132bbd50d1572c7b61dc4cfd14d8edc1f',
     armv7l: '5de726299cbd8469b6c846cf437aac9132bbd50d1572c7b61dc4cfd14d8edc1f',
     x86_64: 'f8750b816aed2fac643ae65028048344d4736ab4e7968b754fe186b32514f85b'
  })

  depends_on 'mesa'
  depends_on 'dbus'
  depends_on 'libconfig'
  depends_on 'libev'
  depends_on 'pcre'
  depends_on 'pixman'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_renderutil'
  depends_on 'xdg_base'
  depends_on 'uthash'
  depends_on 'desktop_file_utilities'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build -Dopengl=false" # Glx backend cannot be used yet
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end

  def self.postinstall
    puts
    puts 'Note that picom requires a Window Manager to be running.  Sommelier does not count.'.lightblue
    puts 'Some examples are: Berry, Openbox, i3, sowm, bspwm, and dwm'.lightblue
    puts
  end
end
