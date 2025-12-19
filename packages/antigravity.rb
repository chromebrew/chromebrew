require 'package'

class Antigravity < Package
  description 'Next-generation IDE from Google'
  homepage 'https://antigravity.google/'
  version '1.12.4'
  license 'Google Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  # To display this url, the latest Debian package must be installed and then run 'apt download --print-uris antigravity'
  source_url 'https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian/antigravity_1.12.4-1765945650_amd64_2e1596b9e78009717589d375637bab9f.deb'
  source_sha256 'b19ba8495542ae75152df7c111330a36c6f7ba8358c015734418ad2f2847ae4d'

  no_compile_needed

  depends_on 'sommelier'

  def self.preflight
    # Need at least 1.4 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(1468006400)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'share', CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/antigravity/bin/antigravity", "#{CREW_DEST_PREFIX}/bin/antigravity"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.antigravity")
    Package.agree_to_remove("#{HOME}/.gemini")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/Antigravity")
  end
end
