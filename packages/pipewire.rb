require 'buildsystems/meson'

class Pipewire < Meson
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  version '1.6.3'
  compatibility 'aarch64 armv7l x86_64'
  license 'LGPL-2.1+'
  source_url 'https://gitlab.freedesktop.org/pipewire/pipewire.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d5370bb611e801e75e7e3364589fe9d645e4d2a8455dac1e54da006612ce868',
     armv7l: '7d5370bb611e801e75e7e3364589fe9d645e4d2a8455dac1e54da006612ce868',
     x86_64: '1e6691d5a66b5004e597ca2f28f2b47ce292aa08da8e44a789b224c8f474c906'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'alsa_plugins' => :build
  depends_on 'avahi' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'dbus' => :library
  depends_on 'elogind' => :build
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gstreamer' => :library
  depends_on 'gstreamer' => :logical
  depends_on 'jack' => :library
  depends_on 'libdrm' => :library
  depends_on 'libmysofa' => :library
  depends_on 'libsndfile' => :library
  depends_on 'libudev_stub' => :library
  depends_on 'lilv' => :library
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :library
  depends_on 'opus' => :library
  depends_on 'pulseaudio' => :library
  depends_on 'py3_lxml' => :build
  depends_on 'readline' => :executable
  depends_on 'vdev' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'webrtc_audio_processing' => :library

  def self.prebuild
    # Without running the ca_certificates postinstall armv7l build breaks
    # complaining about the network not working.
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  # -lpthread is needed for pre-Glibc 2.30 with the c11threads package.
  pre_meson_options "CC='gcc -lpthread' CXX='g++ -lpthread' LDFLAGS='#{CREW_LINKER_FLAGS} -pthread'"
  meson_options "-Dbluez5-backend-hsphfpd=disabled \
      -Dbluez5-backend-ofono=disabled \
      -Dbluez5=disabled \
      -Dexamples=disabled \
      -Dsession-managers=[] \
      -Dtest=disabled \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d \
      -Dv4l2=disabled \
      -Dvolume=auto \
      -Dvulkan=enabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    Dir.chdir("#{CREW_DEST_PREFIX}/include") do
      FileUtils.ln_sf 'spa-0.2/spa', 'spa'
      FileUtils.ln_sf 'pipewire-0.3/pipewire', 'pipewire'
    end
  end
end
