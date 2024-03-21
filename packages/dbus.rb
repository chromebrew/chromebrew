require 'buildsystems/meson'

class Dbus < Meson
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.15.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus.git'
  git_hashtag "dbus-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '65eedead3be809ec5a90dde5455cbee98efe660348497c8595a1d113abbf4c38',
    aarch64: '1f0825d04afb193dc722ce475918764f670148d19dea7b9f6e74a19b8f3f8194',
     armv7l: '1f0825d04afb193dc722ce475918764f670148d19dea7b9f6e74a19b8f3f8194',
     x86_64: 'aba13b6097b7921ebd02c5e9a99cbe50ce00740671f526967ae9a3264d1308e0'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options "-Dapparmor=disabled \
      -Ddbus_session_bus_listen_address='unix:path=/var/run/dbus/system_bus_socket' \
      -Ddoxygen_docs=disabled \
      -Dlibaudit=disabled \
      -Dlaunchd=disabled \
      -Dxml_docs=disabled \
      -Druntime_dir=/var/run \
      -Dsystemd=disabled \
      -Dx11_autolaunch=disabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
      [[ -d '/var/run/dbus' ]] || ( sudo mkdir -p /var/run/dbus && sudo chown chronos /var/run/dbus )
      dbus-uuidgen --ensure
      DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'
      [[ "$DBUS_SESSION_BUS_ADDRESS"=="disabled:" ]] && unset DBUS_SESSION_BUS_ADDRESS
      if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        # if not found, launch a new one
        eval `dbus-launch --sh-syntax`
        # echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
      fi
      dbus-update-activation-environment --all
    DBUSCONFIGEOF
    File.write('env.d_dbus', @dbusconfigenv)
    FileUtils.install 'env.d_dbus', "#{CREW_DEST_PREFIX}/etc/env.d/dbus", mode: 0o644
  end

  def self.postinstall
    FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus" if File.file?("#{CREW_PREFIX}/etc/env.d/03-dbus")
  end
end
