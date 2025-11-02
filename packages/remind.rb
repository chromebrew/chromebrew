require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.01.08'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '685d96e96721df58f1a23bf6075b8d5313a796b9c5910a056fe749b6435ce607'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7775bea89c10b0becf2029693a588edb2f7b38ceec0aac4ba7713a4c9e4c1d6',
     armv7l: 'c7775bea89c10b0becf2029693a588edb2f7b38ceec0aac4ba7713a4c9e4c1d6',
       i686: 'a030d6c3a2e66b0188dc481bcf6eccba3e3ce664e37cee5dae4c600040bc16a2',
     x86_64: '1c3dab44607e67bcdf9414655fa15f3d9a47d4d15804dea92d678b970a81e27f'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'tk' unless ARCH.eql?('i686') # Needed for tkremind.

  autotools_install_extras do
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.touch "#{CREW_DEST_HOME}/.reminders"
  end
end
