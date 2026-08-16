require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "4.0.5-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bd6e7cff9857fac7b1f0c360f56227585553780d05441c4ef8a2be3d264f302',
     armv7l: '0bd6e7cff9857fac7b1f0c360f56227585553780d05441c4ef8a2be3d264f302',
     x86_64: '0254adfe50c8017adc501b6edcb441bd19f293367e884986f1c405b1bd14d21c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' => :library
  depends_on 'libdb' => :library
  depends_on 'libxml2' => :executable
  depends_on 'libxml2' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'vala' => :build

  cmake_options '-DLIBICAL_BUILD_DOCS=false \
      -DLIBICAL_BUILD_TESTING=false \
      -DLIBICAL_GLIB_VAPI=true \
      -DLIBICAL_GOBJECT_INTROSPECTION=true \
      -DLIBICAL_JAVA_BINDINGS=false'
end
