require 'package'

class Bleachbit < Package
  description 'Bleachbit provides a means to clean your system and free disk space.'
  homepage 'https://www.bleachbit.org/'
  version '4.4.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://download.bleachbit.org/bleachbit-4.4.2.tar.lzma'
  source_sha256 '113686f537be4a9fcfeb99fd2e976a33fb8eeb208fb69c571ec7acd96d7fb21b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bleachbit/4.4.2_armv7l/bleachbit-4.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bleachbit/4.4.2_armv7l/bleachbit-4.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bleachbit/4.4.2_i686/bleachbit-4.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bleachbit/4.4.2_x86_64/bleachbit-4.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '93058ccca4af018b26df9878ba6898a3cb1d7cd7c26cb9617a4bea1173b97697',
     armv7l: '93058ccca4af018b26df9878ba6898a3cb1d7cd7c26cb9617a4bea1173b97697',
       i686: '3757fad8813dc6ad6f6122993336de0c00e9e6cec0583a3c010cdcb179279e5c',
     x86_64: '9fce1a604d77059c43980dae5cbe13c3779b88e9e58ab164e49223ec3901c7cf'
  })

  depends_on 'pygobject'
  depends_on 'gtk3'
  depends_on 'sommelier'
  depends_on 'py3_mock' => :build # for checks
  depends_on 'py3_requests' => :build # for checks
  depends_on 'py3_psutil' => :build # for checks
  depends_on 'util_linux' => :build # for checks

  def self.patch
    @bleachbit_path_patch = <<~EOF
      diff --git a/bleachbit.py b/bleachbit.py
      index 1dd085b3..0533a55a 100755
      --- a/bleachbit.py
      +++ b/bleachbit.py
      @@ -26,10 +26,10 @@ import os
       import sys

       if 'posix' == os.name:
      -    if os.path.isdir('/usr/share/bleachbit'):
      +    if os.path.isdir('#{CREW_PREFIX}/share/bleachbit'):
               # This path contains bleachbit/{C,G}LI.py .  This section is
               # unnecessary if installing BleachBit in site-packages.
      -        sys.path.append('/usr/share/')
      +        sys.path.append('#{CREW_PREFIX}/share/')

       if os.name == 'nt':
           # change error handling to avoid popup with GTK 3

    EOF
    File.write('chromebrew_path.patch', @bleachbit_path_patch)
    system 'patch -Np1 -i chromebrew_path.patch'
  end

  def self.build
    system 'make', 'delete_windows_files' # removes MS Windows specific cleaners
    system 'make', '-C', 'po', 'local'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Move locales
    FileUtils.mv "#{CREW_DEST_DIR}/usr/share/locale", "#{CREW_DEST_PREFIX}/share"
    FileUtils.rm_rf '/usr/share'
    # Fix shebangs
    Dir["#{CREW_DEST_PREFIX}/bin/bleachbit", \
        "#{CREW_DEST_PREFIX}/share/bleachbit/GUI.py", \
        "#{CREW_DEST_PREFIX}/share/bleachbit/_platform.py", \
        "#{CREW_DEST_PREFIX}/share/bleachbit/CLI.py"].each do |filename|
      system "sed -i 's:#!/usr/bin/python3:#!/usr/bin/env python3:' #{filename}"
    end
    # Add config file
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/bleachbit"
    system "touch #{CREW_DEST_HOME}/.config/bleachbit/bleachbit.ini"
  end

  def self.check
    # Some tests require root privilages
    system 'make tests || true'
  end
end
