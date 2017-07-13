require 'package'

class Kubectl < Package
  description 'Kubernetes command line tool'
  homepage 'https://kubernetes.io'
  version '1.7.0'
  source_url 'https://github.com/kubernetes/kubernetes/archive/v1.7.0.tar.gz'
  source_sha256 '0fe34180a4bb61384894616b1d348cc6350d1ebcbc071c67748864ffd2deb026'

  depends_on "go" => :build
  depends_on "rsync" => :build

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    # Override the -j$NPROC set by crew with -j1 to workaround a race issue
    system "make", "-j1", "generated_files"
    system "make", "kubectl"
  end

  def self.install
    system "install", "-D", "-m", "755", "_output/bin/kubectl", "#{CREW_DEST_DIR}/usr/local/bin/kubectl"
  end
end
