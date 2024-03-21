require 'buildsystems/autotools'

class Avahi < Autotools
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'http://www.avahi.org/'
  version '0.9-rc1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/avahi/avahi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '9d676e30ef2a4086479ef269c3430e2619114a8ddadd1809941edcaf815afead',
    aarch64: '73dc564fe8de40bfdb67d44fe02152896cd7fdb3251bac125db96552dc0fac58',
     armv7l: '73dc564fe8de40bfdb67d44fe02152896cd7fdb3251bac125db96552dc0fac58',
     x86_64: '2b4c8f3324e2130b5e28417c54e8b4a082abbeac55287ecc4ec24dfb1c3dc7ed'
  })

  depends_on 'dbus' unless ARCH == 'i686' # R
  depends_on 'expat' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libcap' # R
  depends_on 'libdaemon' # R
  depends_on 'libevent' # R
  depends_on 'libssp' # R
  depends_on 'xmltoman' => :build

  configure_options "--disable-dbus \
      --disable-gtk \
      --disable-gtk3 \
      --disable-libsystemd \
      --disable-mono \
      --disable-monodoc \
      --disable-python \
      --disable-qt3 \
      --disable-qt4 \
      --disable-qt5 \
      --with-distro=none"
end
