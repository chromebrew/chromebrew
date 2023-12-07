require 'buildsystems/meson'

class Shotwell < Meson
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.4'
  license 'GPL-2.1+'
  compatibility 'x86_64'
  source_url 'https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.4.tar.xz'
  source_sha256 'de2a9450846d1cec14c6a1030375fd49e1af24dc920ad6480344124f9ccb856f'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.4_x86_64/shotwell-0.32.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'f76a780eb7753bacb7d682de076ac4eedebfcc8679490e7a32f43e87e192dbb3'
  })

  print_source_bashrc

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
  depends_on 'py3_libxml2' # R
  depends_on 'sqlite' # R
  depends_on 'webkit2gtk' # R
end
