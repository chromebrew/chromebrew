require 'package'

class Kubectl < Package
  description 'Kubernetes command line tool'
  homepage 'https://kubernetes.io'
  version '1.7.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kubernetes/kubernetes/archive/v1.7.0.tar.gz'
  source_sha256 '0fe34180a4bb61384894616b1d348cc6350d1ebcbc071c67748864ffd2deb026'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kubectl/1.7.0_armv7l/kubectl-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kubectl/1.7.0_armv7l/kubectl-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kubectl/1.7.0_i686/kubectl-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kubectl/1.7.0_x86_64/kubectl-1.7.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9743623318ffeeaf659364297d5d8f81c9eaa8d78e9319308fc01dfb6b0ec724',
     armv7l: '9743623318ffeeaf659364297d5d8f81c9eaa8d78e9319308fc01dfb6b0ec724',
       i686: 'd9a2c48ab4fee90e1ff681bf73842f1896ed1e82344dc1e3bd0d81bb6010e590',
     x86_64: '0c8d84f6d8802892d6cea9e238fd8fe132cb8db117467d85ba5e94dcaae30de4'
  })

  depends_on 'go' => :build
  depends_on 'rsync' => :build

  def self.build
    # Override the -j$NPROC set by crew with -j1 to workaround a race issue
    system 'make', '-j1', 'generated_files'
    system 'make', 'kubectl'
  end

  def self.install
    system 'install', '-D', '-m', '755', '_output/bin/kubectl', "#{CREW_DEST_PREFIX}/bin/kubectl"
  end
end
