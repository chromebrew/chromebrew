require 'package'

class Shotwell < Package
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.1'
  license 'GPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.1.tar.xz'
  source_sha256 '4ac4517416ad8aa23b44e75c34bd6e16bab7363fa20991bb09bacdfab3f763ce'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.1_armv7l/shotwell-0.32.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.1_armv7l/shotwell-0.32.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.1_x86_64/shotwell-0.32.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '74b2761fe3bac1dda3a107fa06f6e5b77d3971064a8c186924a83315b3079ee2',
     armv7l: '74b2761fe3bac1dda3a107fa06f6e5b77d3971064a8c186924a83315b3079ee2',
     x86_64: '3dbaeddb783532faa4d9d61fe2cdcfea2f0ee19f48ee4bc5b83b3952a4e49686'
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

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

  def self.postinstall
    puts "\nTo finish the installation, execute 'source ~/.bashrc'\n".lightblue
  end
end
