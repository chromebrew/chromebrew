require 'package'

class Gitkraken < Package
  description 'The legendary Git GUI for Windows, Mac and Linux'
  homepage 'https://www.gitkraken.com/git-client'
  version '6.5.4'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz'
    source_sha256 '9b885d9668379693dc69ce589b3c7c4788695d03fea91f35433bfd3d29591d89'
    depends_on 'gtk3'
    depends_on 'libgit2'
    depends_on 'sommelier'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gitkraken-6.5.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '71213a6e8a542787c455e2480a78ba7463be1573263bdfcef8fc499b61355b4a',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv Dir.pwd, "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gitkraken/gitkraken", "#{CREW_DEST_PREFIX}/bin/gitkraken"
  end
end
