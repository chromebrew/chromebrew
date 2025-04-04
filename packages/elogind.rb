require 'package'

class Elogind < Package
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  @_ver = '246.10'
  version "#{@_ver}-1"
  license 'CC0-1.0, LGPL-2.1+ and public-domain'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/elogind/elogind/archive/v#{@_ver}.tar.gz"
  source_sha256 'c490dc158c8f5bca8d00ecfcc7ad5af24d1c7b9e59990a0b3b1323996221a922'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     armv7l: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     x86_64: 'a12c145e41d5f8691731bf29a3d832f7974fea3e887677b649dbc43ea5888a9a'
  })

  depends_on 'eudev'
  depends_on 'libcap'
  depends_on 'linux_pam' # For _pam_macros.h
  depends_on 'dbus'
  depends_on 'docbook_xsl'
  depends_on 'gperf'
  depends_on 'libxslt'
  depends_on 'shadow'
  depends_on 'glib'
  depends_on 'polkit'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dc_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      -Dc_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      -Dcpp_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      -Dcpp_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      -Drootprefix=#{CREW_PREFIX} \
      -Dsysconfdir=#{CREW_PREFIX}/etc \
      --strip \
      -Dcgroup-controller=elogind \
      -Dman=true \
      -Ddefault-hierarchy=legacy \
      -Ddefault-kill-user-processes=false \
      -Dhalt-path=/sbin/halt \
      -Drootlibdir=#{CREW_PREFIX}/#{ARCH_LIB} \
      -Drootlibexecdir=#{CREW_PREFIX}/libexec/elogind \
      -Drootbindir=#{CREW_PREFIX}/bin \
      -Dreboot-path=/sbin/reboot \
      builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
