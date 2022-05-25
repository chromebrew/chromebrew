require 'package'

class Suitesparse < Package
  description 'A suite of sparse matrix software'
  homepage 'http://faculty.cse.tamu.edu/davis/suitesparse.html'
  version '5.7.2'
  license 'metapackage'
  compatibility 'all'
  source_url 'https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v5.7.2.tar.gz'
  source_sha256 'fe3bc7c3bd1efdfa5cffffb5cebf021ff024c83b5daf0ab445429d3d741bd3ad'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/suitesparse/5.7.2_armv7l/suitesparse-5.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/suitesparse/5.7.2_armv7l/suitesparse-5.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/suitesparse/5.7.2_i686/suitesparse-5.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/suitesparse/5.7.2_x86_64/suitesparse-5.7.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '458d03ffa601714d5e3a1f1990c6dfa76b39a79e8d3335405f60e51e0ab6a669',
     armv7l: '458d03ffa601714d5e3a1f1990c6dfa76b39a79e8d3335405f60e51e0ab6a669',
       i686: '4026a0b7db677f9142ee203a43743746fb51992fa110cb9a9301068c5f9ddbf1',
     x86_64: '27a3a4e09af73dedd4f12c7ed446cba87dc7195cd2f90fb69313d2199cee4f66'
  })

  depends_on 'lapack'
  depends_on 'openblas'

  def self.build
    system 'make', 'library'
  end

  def self.install
    system 'make', "INSTALL=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH == '86_64'
  end
end
