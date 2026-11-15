require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.2.3'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36950cb261fe58dfc888c5654e89215707446df2d317835b4c7406a60de6e813',
     armv7l: '36950cb261fe58dfc888c5654e89215707446df2d317835b4c7406a60de6e813',
     x86_64: '8fa61ae6e6a077e43e6b2b35795f814fc74fcb063658418175d19da6dad0aebb'
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
  depends_on 'libvips' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxmlb' => :library
  depends_on 'pango' => :library
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' => :library

  meson_options '-Dapidocs=false -Dcompose=true -Dsystemd=false -Dvapi=true -Dblake3-support=false'

  def self.patch
    patches = [
      # https://github.com/ximion/appstream/issues/794
      ['https://github.com/ximion/appstream/commit/2cf338e0e9f1c711844e1e55ac853cf5ed307678.patch', 'ec2d1d883e0c2c25091d53f745c718882626016bf94989e471dcc30d135e8bfa']
    ]
    ConvenienceFunctions.patch(patches) if version == '1.2.1'
  end

  def self.postinstall
    ExitMessage.add "\nType 'appstreamcli --help' to get started.\n"
  end
end
