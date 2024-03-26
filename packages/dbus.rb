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
       i686: '0ddb3133900cdb865f04c7895c27d805b8688be91b7ba6f947a4c4bc52ec6b7f',
    aarch64: '749147a92583548722756739f7896397113e35ec3b32bd5d1bf4542e2bf3472a',
     armv7l: '749147a92583548722756739f7896397113e35ec3b32bd5d1bf4542e2bf3472a',
     x86_64: 'a69470cf5e74f2cba431697a821b902c0fddf6b9b5e1e4a192d00b773a5dc1e6'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  print_source_bashrc

  meson_options "-Dapparmor=disabled \
      -Ddbus_session_bus_listen_address=unix:tmpdir=/tmp \
      -Ddoxygen_docs=disabled \
      -Dlibaudit=disabled \
      -Dlaunchd=disabled \
      -Dxml_docs=disabled \
      -Druntime_dir=/var \
      -Dlocalstatedir=#{CREW_PREFIX}/var \
      -Dsystemd=disabled \
      -Dx11_autolaunch=disabled"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
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
