require 'package'

class Vulkansdk < Package
  description 'Vulkan SDK'
  homepage 'https://vulkan.lunarg.com/'
  version '1.3.280.1'
  license 'https://vulkan.lunarg.com/license/#/license'
  compatibility 'x86_64'
  min_glibc '2.31'
  source_url 'https://sdk.lunarg.com/sdk/download/1.3.280.1/linux/vulkansdk-linux-x86_64-1.3.280.1.tar.xz'
  source_sha256 '0bdd5dfc32891eccd38d3377570346040bbdb8921d5294c7ca0f27e0c8ba7332'

  depends_on 'libglvnd'
  depends_on 'libxcomposite'
  depends_on 'libxkbcommon'
  depends_on 'vulkan_headers'
  depends_on 'vulkan_icd_loader'
  depends_on 'vulkan_tools'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'
  depends_on 'xdg_base'

  no_shrink
  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-vulkansdk", <<~EOF
      # Vulkan SDK environment
      VK_LAYER_PATH=#{CREW_PREFIX}/share/vulkan/explicit_layer.d
    EOF
    Dir.chdir 'x86_64' do
      # Remove conflicts with vulkan_icd_loader
      FileUtils.rm Dir['lib/cmake/VulkanLoader/*.cmake']
      FileUtils.rm Dir['lib/libvulkan.so*']
      # Remove conflicts with vulkan_headers
      FileUtils.rm Dir['include/vk_video/*']
      FileUtils.rm Dir['share/cmake/VulkanHeaders/*']
      FileUtils.rm_rf Dir['share/vulkan/registry/*']
      # Remove conflicts with vulkan_tools
      Dir.chdir 'bin' do
        %w[vkcube vkcubepp vkcube-wayland vulkaninfo].each do |bin|
          FileUtils.rm bin
        end
      end
      # Rename for LD_LIBRARY_PATH on x86_64
      FileUtils.mv 'lib', 'lib64'
      FileUtils.mv Dir['include/vulkan/*'], 'include'
      FileUtils.rm_rf 'include/vulkan'
      %w[bin include lib64 share].each do |dir|
        FileUtils.mv dir, CREW_DEST_PREFIX
      end
    end
  end

  def self.postinstall
    ExitMessage.add "\nSee https://github.com/KhronosGroup/Vulkan-Guide.".lightblue
  end

  def self.remove
    config_dirs = ["#{HOME}/.local/share/vulkan", "#{HOME}/VulkanSDK"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir
      print "\nWould you like to remove #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightblue
      end
    end
  end
end
