require 'buildsystems/autotools'

class Ndisc6 < Autotools
  description 'Small collection of useful tools for IPv6 networking (ndisc6, rdisc6, tcptraceroute6, traceroute6, rdnssd).'
  homepage 'https://www.remlab.net/ndisc6/'
  version '1.0.9'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.remlab.net/files/ndisc6/ndisc6-#{version}.tar.bz2"
  source_sha256 '1fdcd2f2abc8a69f182631a53902d0720fc8b00703e2d9131dadab7e327f478b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'deabc90c2f621f0b3a945f77854312ca3f0376cc5d9e62f264d5e3885ed127aa',
     armv7l: 'deabc90c2f621f0b3a945f77854312ca3f0376cc5d9e62f264d5e3885ed127aa',
       i686: 'cb816a7766d0fd6a0bd9c4cf55c47ff1814cfd8f13829b5caf4cce1704ae0532',
     x86_64: '1a16c389a59809e2e7deadf00db9f0294cef07f6277ba9b3154f44778e76785b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--disable-suid-install'
end
