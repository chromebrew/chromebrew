require 'buildsystems/meson'

class Elogind < Meson
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  version "257-39c31cd"
  license 'CC0-1.0, LGPL-2.1+ and public-domain'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/elogind/elogind.git'
  git_hashtag '39c31cd9b2cdfccdb73cb9a21df5ac731b23a650'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     armv7l: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     x86_64: 'a12c145e41d5f8691731bf29a3d832f7974fea3e887677b649dbc43ea5888a9a'
  })

  depends_on 'eudev' => :build
  depends_on 'libcap' => :build
  depends_on 'linux_pam' # L
  depends_on 'dbus' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gperf' => :build
  depends_on 'libxslt' => :build
  depends_on 'shadow' => :build
  depends_on 'glib' => :build
  depends_on 'polkit' => :build

  meson_options "-Dsplit-bin=false \
      -Dsysconfdir=#{CREW_PREFIX}/etc \
      -Dtranslations=false \
      -Dcgroup-controller=elogind \
      -Dman=true \
      -Ddefault-hierarchy=legacy \
      -Ddefault-kill-user-processes=false \
      -Dhalt-path=/sbin/halt \
      -Dreboot-path=/sbin/reboot"
end
