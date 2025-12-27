require 'package'

class Penguins_eggs < Package
  description 'A professional and universal remastering tool for all major distributions'
  homepage 'https://penguins-eggs.net/'
  version '25.12.16'
  license 'GPL-2, MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/pieroproietti/penguins-eggs/releases/download/v#{version}/penguins-eggs-#{version}-5-x86_64.AppImage"
  source_sha256 '07dadbaff5422a96f93eed2b28f1f82b296c33c92dcd80a56a9d915e4e120d24'

  depends_on 'gtk3'

  no_compile_needed
  no_shrink

  def self.preflight
    # Need at least 1 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(1073741824)
  end

  def self.build
    File.write 'eggs.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/eggs
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/eggs"
    FileUtils.install 'eggs.sh', "#{CREW_DEST_PREFIX}/bin/eggs", mode: 0o755
    FileUtils.mv Dir['usr/share/*'], "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/eggs"
  end

  def self.postinstall
    ExitMessage.add "\nType 'eggs' to get started.\n"
  end
end
