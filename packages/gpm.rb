require 'package'

class Gpm < Package
  description 'A mouse server for the console and xterm'
  homepage 'https://www.nico.schottelius.org/software/gpm/'
  version '1.20.7-e82d'
  compatibility 'all'
  source_url 'https://github.com/telmich/gpm/archive/e82d1a653ca94aa4ed12441424da6ce780b1e530.zip'
  source_sha256 'd3a693fde3eb1176fdcbee78768f18115e0b634c4ce29a3c3ccc953ba20e10bf'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gpm-1.20.7-e82d-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gpm-1.20.7-e82d-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gpm-1.20.7-e82d-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gpm-1.20.7-e82d-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4a14aada6427aa44ca96c59b24efc36352e44b67037a3cc44b14a43c529d128a',
     armv7l: '4a14aada6427aa44ca96c59b24efc36352e44b67037a3cc44b14a43c529d128a',
       i686: 'dd67b22232f2376f7eb343cf3c6adc31f037e152b6b946e9def7803706224f1d',
     x86_64: 'deddcca380cff6e26b34eb93ff6902d50fc6107f35e5fc21022a8ee4ef7c5bde'
  })

  depends_on 'procps'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/systemd/system"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/profile.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/profile.d"
    # via https://github.com/archlinux/svntogit-packages/tree/master/gpm/trunk
    @gpm_path = <<~'GPM_PATH_EOF'
      [Unit]
      Description=Virtual console mouse server
      
      [Path]
      PathExists=/dev/input/mice
    GPM_PATH_EOF
    IO.write("#{CREW_DEST_PREFIX}/systemd/system/gpm.path", @gpm_path)
    FileUtils.chmod 0o644, "#{CREW_DEST_PREFIX}/systemd/system/gpm.path"
    @gpm_service = <<~GPM_SERVICE_EOF
            [Unit]
            Description=Virtual console mouse server
            Requires=systemd-udevd.service
            After=systemd-udevd.service
            Wants=gpm.path
            ConditionPathExists=/dev/input/mice

            [Service]
            Type=forking
            ExecStart=#{CREW_PREFIX}/bin/gpm -m /dev/input/mice -t imps2

            [Install]
            WantedBy=multi-user.target
    GPM_SERVICE_EOF
    IO.write("#{CREW_DEST_PREFIX}/systemd/system/gpm.service", @gpm_service)
    FileUtils.chmod 0o644, "#{CREW_DEST_PREFIX}/systemd/system/gpm.service"
    Dir.chdir CREW_DEST_LIB_PREFIX do
      system 'ln -sfr libgpm.so.2.* libgpm.so'
    end
    FileUtils.chmod 0o755, Dir.glob("#{CREW_DEST_LIB_PREFIX}/libgpm.so.*")
  end
end
