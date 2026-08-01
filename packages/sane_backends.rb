require 'buildsystems/autotools'

class Sane_backends < Autotools
  description 'Scanner Access Now Easy - Backends'
  homepage 'http://www.sane-project.org/'
  version '1.4.0'
  license 'GPL-2 and public-domain'
  compatibility 'all'
  source_url 'https://gitlab.com/sane-project/backends.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd928dc4dc4a875d01c6418add252d69975a8554a9b18317a3bcbb94b356cba43',
     armv7l: 'd928dc4dc4a875d01c6418add252d69975a8554a9b18317a3bcbb94b356cba43',
       i686: '28a24252fa1033e8b477bc039849b871d992280d2595872d724bd5d7fdef220a',
     x86_64: '9eaee63abdc714a7b9ded89568da6fc963a7f98afe7ca70e40122b2128303ba1'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'avahi' => :library
  depends_on 'curl' => :library
  depends_on 'dbus' => :executable
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libssp' => :executable
  depends_on 'libtiff' => :library
  depends_on 'libusb' => :library
  depends_on 'libxml2' => :library
  depends_on 'v4l_utils' => :library
end
