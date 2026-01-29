require 'package'

class Android_studio < Package
  description 'Android Studio is the official IDE for Android development.'
  homepage 'https://developer.android.com/studio'
  version '2025.2.1.7'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/#{version}/android-studio-#{version}-linux.tar.gz"
  source_sha256 '16af1fa02d746e4c182d8852ff3859bba5c182768efeacfa18a8b81d65e78cb1'

  depends_on 'openjdk17'
  depends_on 'xdg_base'
  depends_on 'sommelier' => :logical

  print_source_bashrc

  @short_ver = version.sub(/\.\d+$/, '')

  def self.preflight
    # Need at least 7.5 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(8053063680)
  end

  def self.patch
    # product-info.json must exist in the installation directory.
    system "sed -i '7i[ ! -f \$(pwd)/product-info.json ] && touch product-info.json' bin/studio.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.mv 'plugins', "#{CREW_DEST_PREFIX}/share/android-studio"
    FileUtils.touch "#{CREW_DEST_PREFIX}/share/android-studio/product-info.json"
    FileUtils.ln_s "#{CREW_PREFIX}/share/android-studio/bin/studio.sh", "#{CREW_DEST_PREFIX}/bin/studio"
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache/Google/AndroidStudio#{@short_ver}/tmp"
    ExitMessage.add "\nType `studio` to start using Android Studio.\n"
  end

  def self.postremove
    # Needed until bug in #13322 is fixed.
    FileUtils.rm_rf "#{CREW_PREFIX}/share/android-studio"
    Package.agree_to_remove("#{CREW_PREFIX}/.cache/Google/AndroidStudio#{@short_ver}")
    Package.agree_to_remove("#{HOME}/.android")
    Package.agree_to_remove("#{HOME}/Android")
    Package.agree_to_remove("#{HOME}/StudioProjects")
  end
end
