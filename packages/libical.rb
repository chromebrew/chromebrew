require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "4.0.0-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5d7ad1b38b3ae0bd6b418c993b102fa6e7b3c9707c1d4768921d8a321d3dba5',
     armv7l: 'a5d7ad1b38b3ae0bd6b418c993b102fa6e7b3c9707c1d4768921d8a321d3dba5',
     x86_64: '7fb99376b41d44af2c04932202e09d63dbbdfde718cf7c8c37a7f2fd0bb5c949'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' => :library
  depends_on 'libdb' => :library
  depends_on 'libxml2' => :executable
  depends_on 'libxml2' => :library
  depends_on 'vala' => :build

  cmake_options '-DGOBJECT_INTROSPECTION=true \
      -DICAL_GLIB_VAPI=true \
      -DICAL_BUILD_DOCS=false \
      -DLIBICAL_BUILD_TESTING=false'
end
