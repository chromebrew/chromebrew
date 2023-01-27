require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = if Gem::Version.new(CREW_KERNEL_VERSION.to_s) < Gem::Version.new('3.9')
            '0.3.29'
          elsif Gem::Version.new(CREW_KERNEL_VERSION.to_s) <= Gem::Version.new('5.4')
            '0.3.60'
          else
            '0.3.65'
          end
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pipewire/pipewire.git'
  git_hashtag @_ver

  if Gem::Version.new(CREW_KERNEL_VERSION.to_s) < Gem::Version.new('3.9')
    binary_url({
     i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.29_i686/pipewire-0.3.29-chromeos-i686.tpxz'
    })
    binary_sha256({
     i686: '0dbeda58c4e1db7a180ebfb2b7bc3057cc6966927f4d5ee543953b734dfc4510'
    })
  elsif Gem::Version.new(CREW_KERNEL_VERSION.to_s) <= Gem::Version.new('5.4')
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.60_armv7l/pipewire-0.3.60-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.60_armv7l/pipewire-0.3.60-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.60_x86_64/pipewire-0.3.60-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: '237ad8299b16e6d294a6561a4959efb47fc72ee66d06f51a3863f55dbdedcf78',
       armv7l: '237ad8299b16e6d294a6561a4959efb47fc72ee66d06f51a3863f55dbdedcf78',
       x86_64: '1534c6a7d71870ac60ec77aab0f795e148e63cf2eac61ff6ec58a5d3af23d994'
    })
  else
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.65_armv7l/pipewire-0.3.65-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.65_armv7l/pipewire-0.3.65-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.65_x86_64/pipewire-0.3.65-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: '6a67e384a6beadaa6884732609d4e3aa8e4067f4e46d7e823358494fa804d5e9',
       armv7l: '6a67e384a6beadaa6884732609d4e3aa8e4067f4e46d7e823358494fa804d5e9',
       x86_64: '26dd5457a4c334f87f038108c30db60b7e8de0f5d7259fe5452bef3a60f73bbc'
    })
  end

  depends_on 'alsa_lib' # R
  depends_on 'alsa_plugins' => :build
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'glib' # R
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gstreamer' # R
  depends_on 'jack' # R
  depends_on 'libsndfile' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'avahi' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'lilv' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pulseaudio' # R
  depends_on 'readline' # R
  depends_on 'webrtc_audio_processing' # R

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dbluez5-backend-hsphfpd=disabled \
      -Dbluez5-backend-ofono=disabled \
      -Dbluez5=disabled \
      -Dexamples=disabled \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d \
      -Dv4l2=disabled \
      -Dvolume=auto \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
