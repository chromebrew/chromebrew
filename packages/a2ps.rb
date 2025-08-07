require 'buildsystems/autotools'

class A2ps < Autotools
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'https://www.gnu.org/software/a2ps/'
  version '4.15.7'
  license 'GPL-3'
  # Builds are currently broken on i686: https://savannah.gnu.org/bugs/?65903
  compatibility 'aarch64 armv7l x86_64'
  # Bootstrapping from git fails: https://savannah.gnu.org/bugs/index.php?65830
  source_url "https://ftpmirror.gnu.org/a2ps/a2ps-#{version}.tar.gz"
  source_sha256 '715f38670afd950b4ca71c01f468feefad265ca52d3f112934c63c0a8bfbb8af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     armv7l: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     x86_64: '1e7a0c86ad72bbddcbcb85e01d3d848109ddc9e5680004206a2fc5428d0e261c'
  })

  depends_on 'bdwgc'
  depends_on 'glibc' # R
  depends_on 'libpaper'
  depends_on 'py3_pspdfutils'

  def self.patch
    # Make sure the build references the current automake version.
    am_ver = `automake --version|head -1|cut -d' ' -f4|sed 's,\.[0-9]$,,'`.chomp
    system "sed -i 's,\'1.17\',\'#{am_ver}\',' configure"
  end

  autotools_configure_options ARCH.eql?('x86_64') ? '--enable-year2038' : '--disable-year2038'

  run_tests
end
