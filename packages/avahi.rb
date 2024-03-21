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
       i686: '6b0d2bd1622249bd295b28348edb2e6c0d6e66415cf5b01c9894c8aa6cb8458b',
    aarch64: 'a7952468b6d0019932aa9944a514e0892a0006a16dbfe2106a37635e86461a76',
     armv7l: 'a7952468b6d0019932aa9944a514e0892a0006a16dbfe2106a37635e86461a76',
     x86_64: '05edbae509033df5cef5615969754f504cec959c932232f0324be06b94c4557f'
  })

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
