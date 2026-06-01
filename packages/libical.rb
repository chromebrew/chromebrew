require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "4.0.2-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fca4ca8c38352c98debca430fcbf76a2f9f125b25119faa61a08cb93c7a02986',
     armv7l: 'fca4ca8c38352c98debca430fcbf76a2f9f125b25119faa61a08cb93c7a02986',
     x86_64: '1c03cb9c4156b03049c00bff98740ee4586f4a8179b2278298b0e4f351ab9cb6'
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
