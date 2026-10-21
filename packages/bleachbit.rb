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
    aarch64: 'a1a9e786665b3a43b443eb86a934e7f3690e5c91f5c62f87ce8f9d55dd2650e5',
     armv7l: 'a1a9e786665b3a43b443eb86a934e7f3690e5c91f5c62f87ce8f9d55dd2650e5',
     x86_64: '877401c89ac6b1c6ee3bb8421850a2b097fadca5743ece1d4b89355e6dc58cd6'
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
