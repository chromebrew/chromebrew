require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '82.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/82.0/linux-i686/en-US/firefox-82.0.tar.bz2'
    source_sha256 '2039a8e94fcda9bcad97d62059579d64744da522c7d65beac0edcbd2e128a06f'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/82.0/linux-x86_64/en-US/firefox-82.0.tar.bz2'
    source_sha256 '4305f43e72aa46ae42882eaa4e436b22c5142a4c9b2dc9f9ccc3292e18a5e39a'
  end

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'gtk3'
    depends_on 'sommelier'
    depends_on 'apulse'
  end

  def self.build
    system "echo '#!/bin/bash' > firefox.sh"
    system "echo 'cd #{CREW_PREFIX}/firefox' >> firefox.sh"
    system "echo 'apulse ./firefox \"\$@\"' >> firefox.sh"

    FileUtils.mkdir_p "defaults/profile/"
    system "echo 'user_pref(\"security.sandbox.content.level\", 2);' > defaults/profile/user.js"
    system "echo 'user_pref(\"security.sandbox.content.read_path_whitelist\", \"/dev/snd/,/home/chronos/user/.asoundrc\");' >> defaults/profile/user.js"
    system "echo 'user_pref(\"security.sandbox.content.syscall_whitelist\", \"16\");' >> defaults/profile/user.js"
    system "echo 'user_pref(\"security.sandbox.content.tempDirSuffix\", \"f7640509-8875-4b18-85d8-0da0696df65b\");' >> defaults/profile/user.js"
    system "echo 'user_pref(\"security.sandbox.content.write_path_whitelist\", \"/dev/snd/\");' >> defaults/profile/user.js"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
    system "install -Dm755 firefox.sh #{CREW_DEST_PREFIX}/bin/firefox"
  end
end
