require 'buildsystems/python'

class Bleachbit < Python
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version '6.0.5'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/bleachbit/bleachbit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b58b39ab813a9bc181f4ffa3b0fa858423a3da2a28d8c373847b2f819ddb2577',
     armv7l: 'b58b39ab813a9bc181f4ffa3b0fa858423a3da2a28d8c373847b2f819ddb2577',
     x86_64: '463c124392fa925ff4f93e23c368ee13fa08ba81ca8741deac8c017be1a58f2f'
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
