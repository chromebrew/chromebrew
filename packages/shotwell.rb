require 'package'

class Shotwell < Package
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.0'
  license 'GPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.0.tar.xz'
  source_sha256 '1772b2fa1e7a5479d528028bc9a303f2855e1d959a5b3c917922e63a98a90b19'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.0_armv7l/shotwell-0.32.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.0_armv7l/shotwell-0.32.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shotwell/0.32.0_x86_64/shotwell-0.32.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '088c46df2ab44dd0279c06cacc8b76a6fc2aef0463616f0df531b8476fa45082',
     armv7l: '088c46df2ab44dd0279c06cacc8b76a6fc2aef0463616f0df531b8476fa45082',
     x86_64: 'a998826a68da79628baabdc79c243038762dd32e2b8d1b3e14a46a580e55adf2'
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
