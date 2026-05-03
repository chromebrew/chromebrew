require 'buildsystems/meson'

class Dia < Meson
  description 'Dia Diagram Editor is free Open Source drawing software for Windows, Mac OS X and Linux.'
  homepage 'http://dia-installer.de/'
  version '0.97.3-ad68cc3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/dia.git'
  git_hashtag 'ad68cc378b7a187706bc2648c48b44d16fb80819'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22f7c004be7ac40359e4b9b27b5a8a20fbd614b91bcb129f8bfbf1494593a284',
     armv7l: '22f7c004be7ac40359e4b9b27b5a8a20fbd614b91bcb129f8bfbf1494593a284',
     x86_64: '727f98bb29e35ce43dc8a96a739bbeddba2213ac755e5446e614e6b57c14bcd2'
  })

  depends_on 'appstream' => :library
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :logical
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'graphene' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libart' => :build
  depends_on 'libemf' => :library
  depends_on 'libpng' => :build
  depends_on 'libwmf' => :build
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'ogdf' => :library
  depends_on 'optipng' => :build
  depends_on 'pango' => :library
  depends_on 'poppler' => :library
  depends_on 'py3_pygobject' => :library
  depends_on 'py3_six' => :build
  depends_on 'python3' => :library
  depends_on 'swig1' => :build
  depends_on 'zlib' => :library

  gnome

  meson_options '-Ddoc=false'
end
