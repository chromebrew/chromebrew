require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.18-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.18.tar.xz'
  source_sha256 '8078f5c25e34ab907ce06905d969dc8ef0ccbec367e1e1707c7ecf8460f4254e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.13.18-1_armv7l/dbus-1.13.18-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.13.18-1_armv7l/dbus-1.13.18-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.13.18-1_i686/dbus-1.13.18-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dbus/1.13.18-1_x86_64/dbus-1.13.18-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '85709ef07ef65ade2689ecbce629200f349f493247b949817f3272e6cb504327',
     armv7l: '85709ef07ef65ade2689ecbce629200f349f493247b949817f3272e6cb504327',
       i686: '0315f3eced7198a0850973289f8af06e9f5bdc7aec29834debfaa56556c29c98',
     x86_64: '3a459724ba6e7f14eacc089fb5500b20b7857aa3034cfc58edf2450ad8ac1c02'
  })

  depends_on 'expat' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
              ./configure #{CREW_OPTIONS} \
              --disable-doxygen-docs \
              --disable-xml-docs \
              --disable-apparmor \
              --disable-libaudit \
              --enable-x11-autolaunch \
              --localstatedir=/var \
              --runstatedir=/var/run \
              --with-dbus-session-bus-listen-address=unix:tmpdir=/tmp"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @dbusconfigenv = <<~DBUSCONFIGEOF
      # Dbus settings
      DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'
      [[ "\$DBUS_SESSION_BUS_ADDRESS"=="disabled:" ]] && unset DBUS_SESSION_BUS_ADDRESS
      if [ -z "\${DBUS_SESSION_BUS_ADDRESS}" ]; then
        # if not found, launch a new one
        eval `dbus-launch --sh-syntax`
        # echo "D-Bus per-session daemon address is: \$DBUS_SESSION_BUS_ADDRESS"
      fi
      dbus-update-activation-environment --all
    DBUSCONFIGEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/dbus", @dbusconfigenv)
  end

  def self.postinstall
    FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus"
  end
end
