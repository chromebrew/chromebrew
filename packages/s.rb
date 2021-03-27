require 'package'

class S < Package
  description 'Open a web search in your terminal.'
  homepage 'https://github.com/zquestz/s'
  version '0.5.10'
  license 'GPL-3+'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/zquestz/s/releases/download/v0.5.10/s-linux_arm.zip'
    source_sha256 '4d31cbb3f81a52946d9e40e1d3ebb650d7112c5c3d45c07ae29435bfea2c0dea'
  when 'i686'
    source_url 'https://github.com/zquestz/s/releases/download/v0.5.10/s-linux_386.zip'
    source_sha256 'ff94e41816bcaadbd0edd334fae634e71afd1bb4f2acb5dc52f6849714c64e68'
  when 'x86_64'
    source_url 'https://github.com/zquestz/s/releases/download/v0.5.10/s-linux_amd64.zip'
    source_sha256 '1e9a379071171ffaa28ce4d697389a70b115955335e41cfbbd37197404129d49'
  end

  depends_on 'unzip'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/s/"
    FileUtils.cp "autocomplete/s-completion.bash", "#{CREW_DEST_PREFIX}/share/s/"
    FileUtils.cp 's', "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # s bash completion
      source #{CREW_PREFIX}/share/s/s-completion.bash
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/s", @env)
  end
end
