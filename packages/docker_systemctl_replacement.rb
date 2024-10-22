require 'package'

class Docker_systemctl_replacement < Package
  description 'docker systemctl replacement'
  homepage 'https://github.com/gdraheim/docker-systemctl-replacement'
  version '1.5.8066'
  license 'EUPL'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/docker-systemctl-replacement.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c790c217bdb721fe75d974b263f9871d73bd5c0a4e7ba95c556bd215288effe',
     armv7l: '2c790c217bdb721fe75d974b263f9871d73bd5c0a4e7ba95c556bd215288effe',
       i686: '6bf951970ef5446b3673fb5cae94b78c70a7a2b7b10dd96aa2d8c21679fbd405',
     x86_64: 'f0550490009b99c4daa6ba43bb41a45a4578c5b4fccee309b6c7189615084c60'
  })

  depends_on 'python3'

  def self.patch
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g' files/docker/systemctl3.py"
  end

  def self.install
    # Systemd units should go in "{XDG_CONFIG_HOME}/systemd/user"
    # Units can be accessed via "systemctl status --user unitname"
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_HOME}/.config/systemd/user]
    FileUtils.install 'files/docker/systemctl3.py', "#{CREW_DEST_PREFIX}/bin/systemctl", mode: 0o755
  end
end
