require 'package'

class Bleachbit < Package
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version '4.6.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/bleachbit/bleachbit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f33cbce2cb7a675895a564eee685893c168a832f4fe87d2d074df0371aeaf9dc',
     armv7l: 'f33cbce2cb7a675895a564eee685893c168a832f4fe87d2d074df0371aeaf9dc',
     x86_64: '24ef4d3ad423ca6695b92babb56848b236a83861660f13af2b884c63133abcd6'
  })

  depends_on 'gtk3'
  depends_on 'py3_chardet'
  depends_on 'py3_mock' => :build
  depends_on 'py3_psutil'
  depends_on 'py3_pygobject'
  depends_on 'py3_requests' => :build
  depends_on 'python3', '>= 3.12.0'

  def self.patch
    # Improve portability around hardcoded /usr/share in bleachbit.py; respect destdir and prefix in po/Makefile; correct shebangs
    downloader 'https://patch-diff.githubusercontent.com/raw/bleachbit/bleachbit/pull/1714.patch', '52ce1bc71c273a824f49369fdb467a7fa558c3f0724b0ad4c6ec6b37a633930e'
    system 'git apply 1714.patch'
  end

  def self.install
    # This deletes windows-specific files.
    system 'make', 'delete_windows_files'
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
