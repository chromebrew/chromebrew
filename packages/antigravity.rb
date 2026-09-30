require 'package'

class Antigravity < Package
  description 'Next-generation IDE from Google'
  homepage 'https://antigravity.google/'
  version '1.23.2'
  license 'Google Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  # To display this url, the latest Debian package must be installed and then run 'apt download --print-uris antigravity'
  source_url 'https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian/antigravity_1.23.2-1776332190_amd64_d29aa2e214aa69c5a7199fce43624422.deb'
  source_sha256 'bdd5f32d26791c36640bd2f713f5ebd6e78fe429c3cc27a72668fda6ad6317a4'

  no_compile_needed

  depends_on 'sommelier' => :logical

  def self.preflight
    # Need at least 1.4 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(1468006400)
  end

  def self.build
    File.write 'antigravity.sh', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/share/antigravity/bin/antigravity --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'share', CREW_DEST_PREFIX
    FileUtils.install 'antigravity.sh', "#{CREW_DEST_PREFIX}/bin/antigravity", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'antigravity' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.antigravity")
    Package.agree_to_remove("#{HOME}/.gemini")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/Antigravity")
  end
end
