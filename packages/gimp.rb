require 'buildsystems/meson'

class Gimp < Meson
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '3.2.4'
  license 'GPL-3 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gimp.git'
  git_hashtag "GIMP_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95d67ff810d279b90220cd069fb93619e4c38f5addc90290a83c010c1e241a27',
     armv7l: '95d67ff810d279b90220cd069fb93619e4c38f5addc90290a83c010c1e241a27',
     x86_64: 'fe8a6e034c3f25ac41b1605d0dd146edc778a9b48797033a28ae6d76614aa92c'
  })

  depends_on 'aalib' => :library
  depends_on 'adwaita_icon_theme' => :logical
  depends_on 'alsa_lib' => :library
  depends_on 'appstream' => :executable
  depends_on 'at_spi2_core' => :build
  depends_on 'babl' => :library
  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :logical
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'gegl' => :library
  depends_on 'gexiv2' => :library
  depends_on 'ghostscript' => :library
  depends_on 'gjs' => :logical
  depends_on 'glib' => :library
  depends_on 'glib_networking'
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnome_icon_theme' => :logical
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :executable
  depends_on 'json_glib' => :executable
  depends_on 'lcms' => :library
  depends_on 'libarchive' => :library
  depends_on 'libavif' => :build
  depends_on 'libbacktrace' => :executable
  depends_on 'libexif' => :build
  depends_on 'libgudev' => :library
  depends_on 'libheif' => :library
  depends_on 'libice' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libmng' => :library
  depends_on 'libmypaint' => :executable
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :library
  depends_on 'libsm' => :build
  depends_on 'libtiff' => :library
  depends_on 'libunwind' => :executable
  depends_on 'libwebp' => :library
  depends_on 'libwmf' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxmu' => :library
  depends_on 'libxpm' => :library
  depends_on 'libxslt' # R
  depends_on 'luajit' => :logical
  depends_on 'luajit_lgi' => :logical
  depends_on 'mypaint_brushes' => :build
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pango' => :library
  depends_on 'poppler' => :library
  depends_on 'poppler_data'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pycairo' => :logical
  depends_on 'py3_pygobject' => :logical
  depends_on 'pygtk' => :build
  depends_on 'shared_mime_info' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library

  gnome

  meson_options '-Dbug-report-url=https://github.com/chromebrew/chromebrew/issues'
  meson_install_extras do
    @binaries = %w[gimp gimp-console gimp-test-clipboard gimptool]
    @binaries.each do |binary|
      unless File.file?("#{CREW_DEST_PREFIX}/bin/#{binary}")
        FileUtils.ln_s "#{CREW_PREFIX}/bin/#{binary}-#{version.split('.')[0..1].join('.')}",
                       "#{CREW_DEST_PREFIX}/bin/#{binary}"
      end
    end
    @man1pages = %w[gimp gimp-console gimptool]
    @man5pages = %w[gimprc]
    @man1pages.each do |manpage|
      unless File.file?("#{CREW_DEST_MAN_PREFIX}/man1/#{manpage}.1")
        FileUtils.ln_s "#{CREW_MAN_PREFIX}/man1/#{manpage}-#{version.split('.')[0..1].join('.')}.1",
                       "#{CREW_DEST_MAN_PREFIX}/man1/#{manpage}.1"
      end
    end
    @man5pages.each do |manpage|
      unless File.file?("#{CREW_DEST_MAN_PREFIX}/man5/#{manpage}.5")
        FileUtils.ln_s "#{CREW_MAN_PREFIX}/man5/#{manpage}-#{version.split('.')[0..1].join('.')}.5",
                       "#{CREW_DEST_MAN_PREFIX}/man5/#{manpage}.5"
      end
    end
  end
end
