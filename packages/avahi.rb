require 'buildsystems/autotools'

class Avahi < Autotools
  description 'Avahi is a system which facilitates service discovery on a local network via the mDNS/DNS-SD protocol suite.'
  homepage 'https://avahi.org/'
  version '0.9-rc1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/avahi/avahi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'b589977a70fdb9bb32887425ee855d50f369345f3b2520c9db3dd56bd32fc819',
    aarch64: 'c34e8d66c23cc56cffd351e1c760eb352b73900f1943fb135774f4cd5093699d',
     armv7l: 'c34e8d66c23cc56cffd351e1c760eb352b73900f1943fb135774f4cd5093699d',
     x86_64: '0939b420dceeccf39b7afe71b562ef9f85087913b5191d43357b51e3e1a1d955'
  })

  depends_on 'dbus' # R (needed to enable avahi-client)
  depends_on 'expat' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libcap' # R
  depends_on 'libdaemon' # R
  depends_on 'libevent' # R
  depends_on 'nss_mdns' # L
  depends_on 'libssp' # R
  depends_on 'xmltoman' => :build

  configure_options "--enable-compat-libdns_sd \
      --disable-gtk \
      --disable-gtk3 \
      --disable-libsystemd \
      --disable-mono \
      --disable-monodoc \
      --disable-python \
      --disable-qt3 \
      --disable-qt4 \
      --disable-qt5 \
      --with-avahi-user=chronos \
      --with-avahi-group=chronos \
      --with-autoipd-group=chronos \
      --with-autoipd-user=chronos \
      --with-avahi-priv-access-group=chronos-access \
      --with-distro=none"

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/avahi-daemon.conf", "#{CREW_DEST_PREFIX}/etc/avahi/avahi-daemon.conf.default"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/hosts", "#{CREW_DEST_PREFIX}/etc/avahi/hosts.default"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/services/sftp-ssh.service", "#{CREW_DEST_PREFIX}/etc/avahi/services/sftp-ssh.service.disabled"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/avahi/services/ssh.service", "#{CREW_DEST_PREFIX}/etc/avahi/services/ssh.service.disabled"
    # start avahi-daemon from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
    File.write 'bashd_avahi', <<~BASHDAVAHI_EOF
      [[ $(pgrep -wc avahi-daemon) > 0 ]] || source #{CREW_PREFIX}/bin/startavahi
    BASHDAVAHI_EOF
    FileUtils.install 'bashd_avahi', "#{CREW_DEST_PREFIX}/etc/bash.d/avahi", mode: 0o644
    File.write 'start_avahi', <<~STARTAVAHI_EOF
      if [[ $(pgrep -wc avahi-daemon) > 0 ]]; then
        # distccd is already running.
        # Return or exit depending upon whether script was sourced.
        (return 0 2>/dev/null) && return 0 || exit 0
      elif [[ -f '/.dockerenv' ]]; then
        echo "In container. Avahi daemon will not be started."
        (return 0 2>/dev/null) && return 0 || exit 0
      fi
      hostname="$(hostname)"
      primaryinterface="$(ip route get 1 | awk '{print $5;exit}')"
      localip="$(ip route get 1 | awk '{print $7;exit}')"
      cp #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf.default #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf
      cp #{CREW_PREFIX}/etc/avahi/hosts.default #{CREW_PREFIX}/etc/avahi/hosts

      sed -i "s/#allow-interfaces=eth0/allow-interfaces=$primaryinterface/" #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf
      sed -i "s/#host-name=foo/host-name=$hostname/" #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf
      sed -i "s/#domain-name=local/domain-name=local/" #{CREW_PREFIX}/etc/avahi/avahi-daemon.conf

      echo -e "\n${localip} ${hostname}.local" >> #{CREW_PREFIX}/etc/avahi/hosts
      echo "Enabling Avahi mDNS/DNS-SD daemon for address $localip ..."
      mkdir -p #{CREW_PREFIX}/var/log && touch #{CREW_PREFIX}/var/log/avahi.log
      (sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" #{CREW_PREFIX}/sbin/avahi-daemon &> #{CREW_PREFIX}/var/log/avahi.log &)
    STARTAVAHI_EOF
    FileUtils.install 'start_avahi', "#{CREW_DEST_PREFIX}/bin/startavahi", mode: 0o755
    File.write 'stop_avahi', <<~STOP_AVAHI_EOF
      #!/bin/bash
      killall -9 avahi-daemon
    STOP_AVAHI_EOF
    FileUtils.install 'stop_avahi', "#{CREW_DEST_PREFIX}/bin/stopavahi", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "The avahi daemon will be automatically started, but can be stopped with 'stopavahi' and restarted with 'startavahi'."
  end
end
