require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "3.0.20-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5336ec84daba02741c0b7763c68f5c5c3b70764c66a899f6636106d4632a4f0f',
     armv7l: '5336ec84daba02741c0b7763c68f5c5c3b70764c66a899f6636106d4632a4f0f',
     x86_64: 'cf1c8d63e3dc53d1a013472ebe8643374d96b48006efc22d094b5e03d048ed5a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' # R
  depends_on 'libdb' # R
  depends_on 'libxml2' # R
  depends_on 'vala' => :build

  cmake_options '-DGOBJECT_INTROSPECTION=true \
      -DICAL_GLIB_VAPI=true \
      -DICAL_BUILD_DOCS=false \
      -DLIBICAL_BUILD_TESTING=false'
end
