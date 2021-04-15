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

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/s-0.5.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/s-0.5.15-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/s-0.5.15-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/s-0.5.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10367f04c278a6157f35c3c0bdbc3a1baa4c49aa3d0362681cc031d292dcd4d6',
     armv7l: '10367f04c278a6157f35c3c0bdbc3a1baa4c49aa3d0362681cc031d292dcd4d6',
       i686: '80322df663b3e5a8f72f6ec027f50a857f44f677cdd163abaf12de53ec09f6f5',
     x86_64: '8674e52bef5b72ba4d8e9022bc103bbf5df9f5e97eb21a5cf52661afe66f2ef9',
  })

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
