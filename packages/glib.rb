require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.90.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a073ae862169932843d1c153c7794fdfb3b339691dc558df371147e9b193afb5',
     armv7l: 'a073ae862169932843d1c153c7794fdfb3b339691dc558df371147e9b193afb5',
       i686: '24871a3e313c8a57a0bec5374fb6ae0b6ff0f54feb69af70d29fc2ac70229d23',
     x86_64: '597e31725e5c242aca36e08fec8fe2e9e7def927f97675847896478d9a56bf2d'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glib_stub' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'libffi' => :library
  depends_on 'pcre2' => :library
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :library

  conflicts_ok # Conflicts with glib_stub.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  def self.patch
    # See: https://gitlab.gnome.org/GNOME/glib/-/work_items/4068
    # https://gitlab.gnome.org/GNOME/glib/-/commit/5b7f4b0403d29753d7c8c57f883e55a3366b0f0a
    # Breaks python's LD_LIBRARY_PATH during this build step:
    # Generating girepository/introspection/...h a custom command (wrapped by meson to set env)
    File.write 'reverse_5b7f4b0403d29753d7c8c57f883e55a3366b0f0a.patch', <<~PATCH_EOF
      --- b/girepository/introspection/meson.build
      +++ a/girepository/introspection/meson.build
      @@ -19,13 +19,6 @@

       gi_gen_env_variables = environment()

      -# Use currently built libraries to run g-ir-scanner and the various tools
      -# this may not happen if we don't set the library paths.
      -# FIXME: https://github.com/mesonbuild/meson/issues/16127
      -gi_gen_env_variables.prepend(glib_exec_var_library_path,
      -  fs.parent(libglib.full_path()), fs.parent(libgobject.full_path()),
      -  fs.parent(libgmodule.full_path()), fs.parent(libgio.full_path()))
      -
       if 'address' in glib_sanitizers
         gi_gen_env_variables.append(
           'ASAN_OPTIONS', glib_exec_asan_option_ignore_preload, separator: ',')
      --- b/meson.build
      +++ a/meson.build
      @@ -2727,11 +2727,9 @@
       glib_exec_preloaded_env = {}

       if host_system in ['ios', 'darwin']
      -  glib_exec_var_library_path = 'DYLD_LIBRARY_PATH'
         glib_exec_var_preload = 'DYLD_INSERT_LIBRARIES'
         glib_exec_var_preload_separator = ':'
       else
      -  glib_exec_var_library_path = 'LD_LIBRARY_PATH'
         glib_exec_var_preload = 'LD_PRELOAD'
         glib_exec_var_preload_separator = ' '
       endif
    PATCH_EOF
    system 'patch -Np1 -i reverse_5b7f4b0403d29753d7c8c57f883e55a3366b0f0a.patch' if version == '2.90.1'
  end

  meson_options '-Dglib_debug=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
