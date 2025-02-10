require 'buildsystems/cmake'

class Libical < CMake
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version "3.0.18-#{CREW_ICU_VER}"
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libical/libical.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41707a01e04fa17f6df3705fb955556df1bf852b66cdd02a6f52ffe47546aaca',
     armv7l: '41707a01e04fa17f6df3705fb955556df1bf852b66cdd02a6f52ffe47546aaca',
     x86_64: '670e55ae69fa5a1938b4a46b261fb3b65768fa2ce00fc6ba63d54a2ba91b90ac'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
