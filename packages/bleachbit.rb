require 'buildsystems/python'

class Bleachbit < Python
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version '6.0.3'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/bleachbit/bleachbit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be72e9561fef1f48b4a4c81be48ca0f714565393424c42f198cfc5c79822bd35',
     armv7l: 'be72e9561fef1f48b4a4c81be48ca0f714565393424c42f198cfc5c79822bd35',
     x86_64: '2fed1eca841e55f1bbb6ab03fb3411034861990cdbd8e21638ec9fb07f564700'
  })

  depends_on 'gtk3' => :library
  depends_on 'py3_chardet' => :library
  depends_on 'py3_mock' => :build
  depends_on 'py3_psutil' => :library
  depends_on 'py3_pygobject' => :library
  depends_on 'py3_requests' => :build
  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  python_install_extras do
    # This deletes windows-specific files.
    system 'make', 'delete_windows_files'
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Fix Error in chown() under chownself().
    system "sed -i '172,177d' #{CREW_DEST_PREFIX}/lib/python3.14/site-packages/bleachbit/General.py"
  end
end
