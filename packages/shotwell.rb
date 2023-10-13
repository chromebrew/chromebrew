require 'buildsystems/meson'

class Shotwell < Meson
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.2'
  license 'GPL-2.1+'
  compatibility 'x86_64'
  source_url 'https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.2.tar.xz'
  source_sha256 'a5de53e873216df8f5996c96827bed963d6c6354e045e1796dfd326c6188c263'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.2_x86_64/shotwell-0.32.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '5cdee6e092952d82c60b26a8fd57446a96baebb43681bbc449e39138cc3d75cd'
  })

  depends_on 'vala' => :build
  depends_on 'cairo' # R
  depends_on 'gcr' # R
  depends_on 'gdk_base' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'libgee' # R
  depends_on 'libgphoto' # R
  depends_on 'libgudev' # R
  depends_on 'libportal' # R
  depends_on 'libraw' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libwebp' # R
  depends_on 'libxml2' # R
  depends_on 'json_glib' # R
  depends_on 'sqlite' # R
  depends_on 'webkit2gtk' # R

  def self.postinstall
    puts "\nTo finish the installation, execute 'source ~/.bashrc'\n".lightblue
  end
end
