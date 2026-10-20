require 'buildsystems/python'

class Bleachbit < Python
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version "6.0.6-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/bleachbit/bleachbit.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0df766f2bce20f83a8210e11b56fb0823cfb6aaeb8d3b8b14d6f8dc17e28348b',
     armv7l: '0df766f2bce20f83a8210e11b56fb0823cfb6aaeb8d3b8b14d6f8dc17e28348b',
     x86_64: '3378e9eb4f42f3a2ff1fa494303349c11511959b0e8a498bd7844ce4b3535d99'
  })

  depends_on 'gtk3' => :build
  depends_on 'py3_chardet' => :build
  depends_on 'py3_mock' => :build
  depends_on 'py3_psutil' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'py3_requests' => :build
  depends_on 'py3_standard_pkg_resources' => :build
  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.15.0'

  python_install_extras do
    # This deletes windows-specific files.
    system 'make', 'delete_windows_files'
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Fix Error in chown() under chownself().
    system "sed -i '326,328d' #{CREW_DEST_PREFIX}/lib/python#{CREW_PY_VER.split('y')[1]}/site-packages/bleachbit/General.py"
  end
end
