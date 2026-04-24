require 'package'

class Cheat < Package
  description 'Create and view interactive cheatsheets on the command-line.'
  homepage 'https://github.com/cheat/cheat'
  version '5.1.0'
  license 'MIT'
  compatibility 'all'
  min_glibc '2.32' if ARCH.eql?('x86_64')
  source_url({
    aarch64: "https://github.com/cheat/cheat/releases/download/#{version}/cheat-linux-arm7.gz",
     armv7l: "https://github.com/cheat/cheat/releases/download/#{version}/cheat-linux-arm7.gz",
       i686: "https://github.com/cheat/cheat/releases/download/#{version}/cheat-linux-386.gz",
     x86_64: "https://github.com/cheat/cheat/releases/download/#{version}/cheat-linux-amd64.gz"
  })
  source_sha256({
    aarch64: '1b01797e1ccb482562eaa1b704379373f1fec12657c142443467fefcda09826d',
     armv7l: '1b01797e1ccb482562eaa1b704379373f1fec12657c142443467fefcda09826d',
       i686: '586794f83d13fbb08c47bce47ecdba2e6934becd6bbcfe34e10b584ef5a0c758',
     x86_64: '8c8405574d51d63ee89594bfed241f478d507d96af78e5c370dcbe65633d7b34'
  })

  depends_on 'xdg_base'
  depends_on 'gzip'

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm7'
    when 'i686'
      arch = '386'
    when 'x86_64'
      arch = 'amd64'
    end
    system "gunzip cheat-linux-#{arch}.gz"
    FileUtils.install "cheat-linux-#{arch}", "#{CREW_DEST_PREFIX}/bin/cheat", mode: 0o755
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/cheat")
  end
end
