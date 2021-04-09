require 'package'

class S < Package
  description 'Open a web search in your terminal.'
  homepage 'https://github.com/zquestz/s/'
  @_ver = '0.5.15'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/zquestz/s/releases/download/v#{@_ver}/s-linux_arm.zip"
    source_sha256 'ddffb211f117395a736f679a8a96cc726ac46c50fdfe1a6e2c4bb4494b970cd0'
  when 'i686'
    source_url "https://github.com/zquestz/s/releases/download/v#{@_ver}/s-linux_386.zip"
    source_sha256 '8724b0ea6ec0e8abedcdc87f2efccd12a848ff1267149f8ca14b46251649cffc'
  when 'x86_64'
    source_url "https://github.com/zquestz/s/releases/download/v#{@_ver}/s-linux_amd64.zip"
    source_sha256 '38c29001936f1758159cc935b3ab97d1dee75c35ceacd8bd5ada3837b306192f'
  end

  depends_on 'unzip' => :build

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
