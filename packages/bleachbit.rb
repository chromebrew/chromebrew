require 'buildsystems/python'

class Bleachbit < Python
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version '6.0.4'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/bleachbit/bleachbit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4f5816a8a2b04b989afa085b9653579f3a79a55d8b4c87d02f438eff4715d44',
     armv7l: 'a4f5816a8a2b04b989afa085b9653579f3a79a55d8b4c87d02f438eff4715d44',
     x86_64: 'b4bc5f72f2c7e6cc8ddcdd6d84acb52f983fa92c2b04c0830b19516555fa7f9d'
  })

  depends_on 'gtk3' => :build
  depends_on 'py3_chardet' => :build
  depends_on 'py3_mock' => :build
  depends_on 'py3_psutil' => :build
  depends_on 'py3_pygobject' => :build
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
