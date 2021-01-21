require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.1-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.1.tar.xz'
  source_sha256 '3b3409fe3a93f9e9f6f5dc9cd8405edfd7513b289589987e568369e627d3350c'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ba7c85f0d8b325b0a6c5657593c04dacd7c920675da2476f7a4a28a61fb80cb9',
      armv7l: 'ba7c85f0d8b325b0a6c5657593c04dacd7c920675da2476f7a4a28a61fb80cb9',
        i686: '46c605eb727ec23785bc796d1c1149e424453764d0e18f7c6fda79bf63868863',
      x86_64: 'e95c0ad6959cf02bec7c1ea2950b2bf23a291a775345bb8dc42fb2642453be68',
  })

  depends_on 'pcre2'
  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'

  def self.patch
    # Handle the case of g_object_run_dispose() in GBinding
    # Fixes geany crash in glib 2.67.1
    patch_description = "Handle the case of g_object_run_dispose() in GBinding"
    patch_url = "https://gitlab.gnome.org/GNOME/glib/-/commit/ba621181221f8b2f8f07743df2c02a7a7638f995.patch"
    patch_sha256 = '31fd538f729094dee050f880e41231918c0da76d6545cd853e606f363b467ea3'
    patch_uri = URI.parse patch_url
    patch_filename = 'patch'
    puts "Downloading patch: #{patch_description}".yellow
    system('curl', '-s', '--insecure', '-L', '-#', patch_url, '-o', patch_filename)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( patch_filename ) ) == patch_sha256
    puts "patch downloaded".lightgreen
    system 'patch -p 1 < patch'
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dgtk_doc=false \
    -Diconv=external \
    -Dinternal_pcre=true \
    build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
