require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.03'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '6045283b98e004a683b13a636409ba691401d2ae9e5122d244c151972e923341'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ee6740a1c43ea6c156d30de4bc35b9599407576e0a2e9f66f61af36e932ae6a',
     armv7l: '5ee6740a1c43ea6c156d30de4bc35b9599407576e0a2e9f66f61af36e932ae6a',
       i686: '34246694fe618848c28548ab03d027bea583b93bcd4883cda67c80949b49f773',
     x86_64: '2687c294206eb98f7c441701fc6defa7a38ef24ffc7b4ba1244e91c55b4a9bb1'
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
