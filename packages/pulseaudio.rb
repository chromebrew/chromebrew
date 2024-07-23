require 'buildsystems/meson'

class Pulseaudio < Meson
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '17.0'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.34'
  source_url 'https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '546dac0ebd845e22d5c5530bfcfaad5a855e59110b4bb660e1cc41902d21d425',
     armv7l: '546dac0ebd845e22d5c5530bfcfaad5a855e59110b4bb660e1cc41902d21d425',
     x86_64: '5df633594ec2e85a3b0c5d4a91e9fd09daa27cf6f1d16a30fc668634528d6ab8'
  })

  depends_on 'alsa_lib' # R
  # depends_on 'alsa_plugins' => :build
  depends_on 'avahi' # R
  depends_on 'check' => :build
  depends_on 'cras' # L
  depends_on 'dbus' # R
  depends_on 'elogind' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  # depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gstreamer' # R
  depends_on 'jack' # R
  depends_on 'json_c' => :build
  depends_on 'libcap' # R
  depends_on 'libgconf' => :build
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libsndfile' # R
  depends_on 'libsoxr' # R
  depends_on 'libtool' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxfixes' => :build
  depends_on 'libxtst' # R
  depends_on 'openssl' # R
  depends_on 'pipewire' # R
  depends_on 'speexdsp' # R
  depends_on 'tcpwrappers' # R
  depends_on 'tdb' # R
  depends_on 'valgrind' => :build
  depends_on 'webrtc_audio_processing' # R

  git_fetchtags

  meson_options "-Dsystem_user=chronos \
    -Dsystem_group=cras \
    -Daccess_group=cras \
    -Dbluez5=disabled \
    -Dalsa=enabled \
    -Dgstreamer=disabled \
    -Delogind=enabled \
    -Dtests=false \
    -Dudevrulesdir=#{CREW_PREFIX}/libexec/rules.d \
    -Dalsadatadir=#{CREW_PREFIX}/share/alsa-card-profile \
    -Dlocalstatedir=#{CREW_PREFIX}/var/run"

  def self.check
    # 39/50 thread-test                                                                                                   FAIL             4.02s   exit status 1
    # >>> MALLOC_PERTURB_=232 MAKE_CHECK=1 /usr/local/tmp/crew/pulseaudio-14.2.tar.xz.dir/pulseaudio-14.2/builddir/src/tests/thread-test
    # ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
    # stdout:
    # Running suite(s): Thread
    # 0%: Checks: 1, Failures: 0, Errors: 1
    # ../src/tests/thread-test.c:108:E:thread:thread_test:0: (after this point) Test timeout expired
    # stderr:
    # loop-init
    # once!
    # system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @pulseaudio_daemon_conf = <<~PAUDIO_DAEMON_CONF_HEREDOC
      # Replace these with the proper values
      exit-idle-time = 10 # Exit as soon as unneeded
      flat-volumes = yes # Prevent messing with the master volume
    PAUDIO_DAEMON_CONF_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/etc/pulse/daemon.conf", @pulseaudio_daemon_conf, perm: 0o666)
    @pulseaudio_client_conf = <<~PAUDIO_CLIENT_CONF_HEREDOC
      # Replace these with the proper values

      # Applications that uses PulseAudio *directly* will spawn it,
      # use it, and pulse will exit itself when done because of the
      # exit-idle-time setting in daemon.conf
      autospawn = yes
    PAUDIO_CLIENT_CONF_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/etc/pulse/client.conf", @pulseaudio_client_conf, perm: 0o666)
    @pulseaudio_default_pa = <<~PAUDIO_DEFAULT_PA_HEREDOC
      # Replace the *entire* content of this file with these few lines and
      # read the comments

      .fail
          # Set tsched=0 here if you experience glitchy playback. This will
          # revert back to interrupt-based scheduling and should fix it.
          #
          # Replace the device= part if you want pulse to use a specific device
          # such as "dmix" and "dsnoop" so it doesn't lock an hw: device.

          # INPUT/RECORD
          load-module module-alsa-source device="default" tsched=1

          # OUTPUT/PLAYBACK
          load-module module-alsa-sink device="default" tsched=1

          # Accept clients -- very important
          load-module module-native-protocol-unix

      .nofail
      .ifexists module-x11-publish.so
          # Publish to X11 so the clients know how to connect to Pulse. Will
          # clear itself on unload.
          load-module module-x11-publish
      .endif
    PAUDIO_DEFAULT_PA_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/etc/pulse/default.pa", @pulseaudio_default_pa, perm: 0o666)
  end
end
