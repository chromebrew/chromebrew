require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "4.0.1-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91d638ec936fcc144abfb0ea15070e18cc0b9db5466e75370d593dfd741c9a39',
     armv7l: '91d638ec936fcc144abfb0ea15070e18cc0b9db5466e75370d593dfd741c9a39',
     x86_64: 'cf0d274070a313e829496056793bc8b5c30640e3cac6c25112b8c13c6d758660'
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
