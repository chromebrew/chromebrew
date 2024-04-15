require 'buildsystems/meson'

class Gimp < Meson
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.99.18'
  license 'GPL-3 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/gimp/v2.99/gimp-2.99.18.tar.xz'
  source_sha256 '8c1bb7a94ac0d4d0cde4d701d8b356387c2ecd87abbd35bbf7d222d40f6ddb6e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e538613618d20be74bf6dbb8c8a64c226b0f827dcce487170f4ef8da92a840bd',
     armv7l: 'e538613618d20be74bf6dbb8c8a64c226b0f827dcce487170f4ef8da92a840bd',
     x86_64: '846bbfd31fa3b72a0d21017466f36c787203aa2b54c44d86a878d5bd3d48be07'
  })

  depends_on 'aalib' # R
  depends_on 'adwaita_icon_theme' # L
  depends_on 'alsa_lib' # R
  depends_on 'appstream_glib' # R
  depends_on 'at_spi2_core' => :build
  depends_on 'babl' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gegl' # R
  depends_on 'gexiv2' # R
  depends_on 'ghostscript' # R
  depends_on 'gjs' # L
  depends_on 'glibc' # R
  depends_on 'glib_networking'
  depends_on 'glib' # R
  depends_on 'gnome_icon_theme' # L
  depends_on 'gobject_introspection' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'jsonc' => :build
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libavif' => :build
  depends_on 'libexif' => :build
  depends_on 'libgudev' # R
  depends_on 'libheif' # R
  depends_on 'libice' => :build
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
  depends_on 'libmng' # R
  depends_on 'libmypaint' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' => :build
  depends_on 'libtiff' # R
  depends_on 'libunwind' # R
  depends_on 'libwebp' # R
  depends_on 'libwmf' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxmu' # R
  depends_on 'libxpm' # R
  depends_on 'libxt' => :build
  depends_on 'luajit' # L
  depends_on 'luajit_lgi' # L
  depends_on 'mypaint_brushes_1' => :build
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'poppler_data'
  depends_on 'poppler' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pycairo' # L
  depends_on 'pygobject' # L
  depends_on 'pygtk' => :build
  depends_on 'shared_mime_info' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  gnome

  meson_options '-Dbug-report-url=https://github.com/chromebrew/chromebrew/issues'

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @binaries = %w[gimp gimp-console gimp-test-clipboard gimptool]
    @binaries.each do |binary|
      unless File.file?("#{CREW_DEST_PREFIX}/bin/#{binary}")
        FileUtils.ln_s "#{CREW_PREFIX}/bin/#{binary}-2.99",
                       "#{CREW_DEST_PREFIX}/bin/#{binary}"
      end
    end
    @man1pages = %w[gimp gimp-console gimptool]
    @man5pages = %w[gimprc]
    @man1pages.each do |manpage|
      unless File.file?("#{CREW_DEST_MAN_PREFIX}/man1/#{manpage}.1")
        FileUtils.ln_s "#{CREW_MAN_PREFIX}/man1/#{manpage}-2.99.1",
                       "#{CREW_DEST_MAN_PREFIX}/man1/#{manpage}.1"
      end
    end
    @man5pages.each do |manpage|
      unless File.file?("#{CREW_DEST_MAN_PREFIX}/man5/#{manpage}.5")
        FileUtils.ln_s "#{CREW_MAN_PREFIX}/man5/#{manpage}-2.99.5",
                       "#{CREW_DEST_MAN_PREFIX}/man5/#{manpage}.5"
      end
    end
  end
end
