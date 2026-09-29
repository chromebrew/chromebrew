require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.05'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 'd060f4073fa7a498824dc5a00ab567c92025a7b5121e4651663a86ea787bcdd4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06348e35d18414af0ab65f51a19f347760bebebe9946e136e9cd44c5315f9857',
     armv7l: '06348e35d18414af0ab65f51a19f347760bebebe9946e136e9cd44c5315f9857',
       i686: '58721a9e91134c4abbe9484fdfc17fdc6506291a775064f89089bc70582ce43a',
     x86_64: '0e7d72bbd49d24b3ab38751356b96d6224cd5073584ff234b579de56650b8eba'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'readline' => :executable
  depends_on 'tk' unless ARCH.eql?('i686') # Needed for tkremind.

  autotools_install_extras do
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.touch "#{CREW_DEST_HOME}/.reminders"
  end
end
