require 'buildsystems/meson'

class Appstream < Meson
  description 'Provides a standard for creating app stores across distributions'
  homepage 'https://www.freedesktop.org/wiki/Distributions/AppStream/'
  version '1.2.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ximion/appstream.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2647331aaec4487c5cf5c2bfb76b69c4c560ece9a5c4a0bd0bd9cc4c9313f04',
     armv7l: 'c2647331aaec4487c5cf5c2bfb76b69c4c560ece9a5c4a0bd0bd9cc4c9313f04',
     x86_64: '90ffdaf7c6f122950cceb78e1693280afb1eba1802301aa11cae49c9a40dca50'
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
    # https://github.com/ximion/appstream/issues/794
    File.write 'appstream_openat.patch', <<~OPENAT_PATCH
      diff -Npaur a/compose/asc-directory-unit.c b/compose/asc-directory-unit.c
      --- a/compose/asc-directory-unit.c	2026-09-30 13:58:54.454270875 -0400
      +++ b/compose/asc-directory-unit.c	2026-09-30 13:59:35.757725026 -0400
      @@ -202,7 +202,7 @@ asc_resolve_path_in_root (const gchar *r
       static gint
       asc_openat2 (gint dir_fd, const gchar *path, gint flags)
       {
      -#if defined(HAVE_OPENAT2) || defined(HAVE_LINUX_OPENAT2_H)
      +#if defined(HAVE_OPENAT2) && defined(HAVE_LINUX_OPENAT2_H)
       	struct open_how how = {
       		.flags = flags,
       		.resolve = RESOLVE_IN_ROOT,
    OPENAT_PATCH
    system 'patch -Np1 -i appstream_openat.patch' if version == '1.2.1'
  end

  def self.postinstall
    ExitMessage.add "\nType 'appstreamcli --help' to get started.\n"
  end
end
