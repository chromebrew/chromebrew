require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.1.3'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1468356552fe80bc4e6c0bb27281522027ba9a4a8a3a52a7b832931d5e5c7c10',
     armv7l: '1468356552fe80bc4e6c0bb27281522027ba9a4a8a3a52a7b832931d5e5c7c10',
     x86_64: 'ed8e2f310795dabf2ab970aa131970e1814a68143079790770d767f4780d5883'
  })

  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libfyaml' => :library
  depends_on 'librsvg' => :library
  depends_on 'libstemmer' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxmlb' => :library
  depends_on 'pango' => :library
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'vala' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' => :library

  meson_options '-Dcompose=true -Dsystemd=false -Dvapi=true -Dblake3-support=false'

  def self.postinstall
    ExitMessage.add "\nType 'appstreamcli --help' to get started.\n"
  end
end
