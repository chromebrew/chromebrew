require 'buildsystems/meson'

class Shotwell < Meson
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.17'
  license 'GPL-2.1+'
  compatibility 'x86_64'
  source_url "https://download.gnome.org/sources/shotwell/#{version.split('.')[0..1].join('.')}/shotwell-#{version}.tar.xz"
  source_sha256 '0a56684e98817c3103f54a648fe9400427c76a25a7b111457fc1d860c3167672'
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '1a9d85ea7751bbe2056b3c182b9df6430e86b9239ce1cb12a3ed3ccaa6f652fe'
  })

  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :executable
  depends_on 'gcr' => :library
  depends_on 'gcr_3' => :library
  depends_on 'gdk_base' => :logical
  depends_on 'gdk_pixbuf' => :library
  depends_on 'gexiv2' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gstreamer' => :executable
  depends_on 'gtk3' => :library
  depends_on 'json_glib' => :library
  depends_on 'libexif' => :executable
  depends_on 'libgee' => :library
  depends_on 'libgphoto' => :executable
  depends_on 'libgudev' => :executable
  depends_on 'libportal' => :executable
  depends_on 'libraw' => :executable
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :library
  depends_on 'libwebp' => :executable
  depends_on 'libxml2' => :library
  depends_on 'pango' => :executable
  depends_on 'py3_itstool' => :executable
  depends_on 'py3_libxml2' => :executable
  depends_on 'sqlite' => :executable
  depends_on 'vala' => :build
  depends_on 'webkit2gtk' => :library

  gnome

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/shotwell")
  end
end
