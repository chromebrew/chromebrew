require 'package'

class Conan < Package
  description 'conan is a open-source C/C++ package manager'
  homepage 'https://conan.io'
  version '1.33.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/cf/3b/7fc6030e64609ef6ddf9a3f88c297794d59d89fd2ab13989a9aee47cad02/conan-1.33.0.tar.gz'
  source_sha256 '3debc02daf1be7198ed190322ff6d7deaeab0a2ef3e3f4b23033100cfa9bd8ab'

  depends_on 'pygments'
  

  def self.install
    system "pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} \
            -I conan==#{version} \
            --no-warn-script-location"
  end
end
