require 'package'

class Cheat < Package
  description 'Create and view interactive cheatsheets on the command-line.'
  homepage 'https://github.com/cheat/cheat'
  version '4.4.2'
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
    aarch64: '52ca1e355f46ae36b04717e431ef03b6158e41d1df0c3cf381abe36a147dfe43',
     armv7l: '52ca1e355f46ae36b04717e431ef03b6158e41d1df0c3cf381abe36a147dfe43',
       i686: '1ee7f6b4b40447684c80f3920b1841cb54d9f3f8cd543671c2453c34769cdde1',
     x86_64: 'b81f5ba21f134087c0294d809f89e5442d641d7be297bb128807cbce00849e9b'
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
